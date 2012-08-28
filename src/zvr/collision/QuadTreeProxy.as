/*
 * Copyright (c) 2007-2008, Michael Baczynski
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * * Neither the name of the polygonal nor the names of its contributors may be
 *   used to endorse or promote products derived from this software without specific
 *   prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package zvr.collision 
{
	public class QuadTreeProxy extends Proxy 
	{
		public var nextInNode:QuadTreeProxy;
		public var prevInNode:QuadTreeProxy;
		
		public var nextInTree:QuadTreeProxy;
		public var prevInTree:QuadTreeProxy;
		
		public var node:QuadTreeNode;
		
		public var xl1:int, xl2:int;
		public var yl1:int, yl2:int;
		
		public function remove():void
		{
			if (prevInNode) prevInNode.nextInNode = nextInNode;
			if (nextInNode) nextInNode.prevInNode = prevInNode;
			if (this == node.proxyList) node.proxyList = nextInNode;
			
			prevInNode = null;
			nextInNode = null;
			node = null;
		}
		
		override public function reset():void
		{
			nextInNode = null;
			prevInNode = null;
			nextInTree = null;
			prevInTree = null;
			node = null;
			xl1 = int.MIN_VALUE;
			yl1 = int.MIN_VALUE;	
			xl2 = int.MIN_VALUE;
			yl2 = int.MIN_VALUE;
			super.reset();
		}
	}
}