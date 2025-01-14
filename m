Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4A146590
	for <damon@lists.linux.dev>; Tue, 14 Jan 2025 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891724; cv=none; b=rE0w+MnROFcxF5oZeNCLlyECk19WOB+xZU7TI96M7FNUPfGFRvbtn0O86CqR7/keY+A9cI6FjjRHfG/lGqKc2qvP4BDIeeoMoGFacaZ+mE45fC76Ax2RuyrKzLHl8LZr+clh6igZpmYH0qGcQjqWDCWoVqZrCIgTEEPWjn3U2Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891724; c=relaxed/simple;
	bh=MCrjQkcrrnZW+sJpQFjO0v97J2ttIOTY9JLUt/Eom14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/+lu4rrzuGZNFD+lehGtl1rWiOWmdpEvMzsnZSBAoKtqDmtbS8eXwhUmu4lXuhkNAoi1nSMsuPXNhd6iaIRG0GG3w3HNIH5vcEdut8zykupHL5KpC9k4SOokVkmNNe0Glb5uy/32ELJ4NriOxfSiwVpf2TfoxblFQIfFIsGxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lFWi7HBc; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lFWi7HBc"
Date: Tue, 14 Jan 2025 13:55:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736891711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8ff54+0fr/9rfuy6Lml03OR+cA5iBkChIyVOWCs3ew=;
	b=lFWi7HBcEa0O48lSIqH3GtSNrFdpPHFD1wnx5TSdgENpujqhwGeEt6HMG97jVEYWk6V3vN
	2tmQoL+dxINOjUb2itfapAtcehMSrsSeai2TKMb8bAOV62gN8SsN4arVRS8kdiIAZCpYRc
	AH8/yZ7zHxBmfm6oxHASIhWQ5NkEHOg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Liam.Howlett@oracle.com, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, damon@lists.linux.dev, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/madvise: remove redundant mmap_lock operations
 from process_madvise()
Message-ID: <lnmrfp6f6gucw4oxxdk77bgbrogvepvpxl2kp3teje7iuwn7y5@6jjtkcmwnlmf>
References: <20250111004618.1566-1-sj@kernel.org>
 <awmc5u2j2jmn3xir2tmmxivxpastptevay5kgspgtembiw4et7@5ryv5dnjzdcv>
 <d1a2d831-dec3-4c63-a712-3adff835f549@lucifer.local>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a2d831-dec3-4c63-a712-3adff835f549@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 06:47:15PM +0000, Lorenzo Stoakes wrote:
> On Tue, Jan 14, 2025 at 10:13:40AM -0800, Shakeel Butt wrote:
> > Ccing relevant folks.
> 
> Thanks Shakeel!
> 
> A side-note, I really wish there was a better way to get cc'd, since I
> fundamentally changed process_madvise() recently and was the main person
> changing this code lately, but on the other hand -
> scripts/get_maintainers.pl gets really really noisy if you try to use this
> kind of stat - so I in no way blame SJ for missing me.
> 
> Thankfully Shakeel kindly stepped in to make me aware :)
> 
> SJ - I will come back to you later, as it's late here and my brain is fried
> - but I was already thinking of doing something _like_ this, as I noticed
> for the purposes of self-process_madvise() operations (which I unrestricted
> for guard page purposes) - we are hammering locks in a way that we know we
> don't necessarily need to do.
> 
> So this is serendipitous for me! :) But I need to dig into your actual
> implementation to give feedback here.
> 
> Will come back to this in due course :)
> 

SJ is planning to do couple more optimizations like single tree
traversal (where possible) and batching TLB flushing for advices which
does TLB flushing. It is better to coordinate the work than orthogonally
repeating the work.

Thanks Lorenzo for your time.

Shakeel
