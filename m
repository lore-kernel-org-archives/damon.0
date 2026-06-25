Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04C1CAA78
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782359360; cv=none; b=BupLxBa1dioKDVbur5bmO3xLJWU33UrHjh5LXaQIIJJwz0WOkZiIzVjRblNTXzWidbc1x6iQ8r0Y1VBCoW/tP4knUnereXR/R5QLctcetry9I9nzcbjXXnJBp2wU58WJjEYXWiSX/aTzhvBhy3zuVrNw+1DJ7J5TQZe8rYM5+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782359360; c=relaxed/simple;
	bh=jbmqnPZg7cTlsLd4emjzwR91Gi7eycu229XojE7B56c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGThif5m+m2/QjC0fWfWjgZeus45nupDB5190KWtmOlr5UdYN5VzTVuEcxK23McCKCqDCXE0sL6obTjykL109IQk3+FAryVo6NsP0xi2sSWkvK4BuNqQiUcl2My0EEaLuAUbWRN9k89KbegrCVngrpsaG0KnCBfE0aWFR7OvmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EjYOgoZJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EjYOgoZJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TB55hGeTEaEWWjKg63Nolm76nvhbpFQ166U+vfAH/sQ=; b=EjYOgoZJF1DaphSsqHQkxzbvMm
	JxC+ITiMCsI3tZBmHFxPrIpY8zmCRURbPiPRMnfdfBJ0FCj/UFJcsYf64lXHDIbexZg/SsDptgntQ
	x8oIyGdroeUAEHsbIaw30u/Dnr0gQgWS5Zbm/wFI6RdShqQAr69+aMAHkTUMo7dCm7YrQXkoialYh
	XoVSIPL3JD2rI84PzMe7Izg+kVcAB3InQe2WCLz+0NrzJ/2ryOfVJbs3MQinHk84yILWSVd7vv+u0
	r7RlqIWSE6OL+2/Ibnfeyemx4czyPzuJetrNQxe/puP2g6CBy16inzIA0i9uDLu6DaE2ZyDpNZsNb
	WthJAepw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcb5R-00000009DBG-42Ok;
	Thu, 25 Jun 2026 03:49:10 +0000
Date: Thu, 25 Jun 2026 04:49:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yu Qin <qin.yuA@h3c.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/paddr: remove folio_put from
 damon_pa_invalid_damos_folio
Message-ID: <ajylNXBqzSY0ffoI@casper.infradead.org>
References: <20260625012201.2937854-1-qin.yuA@h3c.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625012201.2937854-1-qin.yuA@h3c.com>

On Thu, Jun 25, 2026 at 09:22:01AM +0800, Yu Qin wrote:
> This boolean function called folio_put() implicitly. Remove the put and let
> callers handle it explicitly, making the get/put pair more clear.

I don't think this is a good change.  It's perfectly fine to have a
function which always puts the ref that is passed to it.  Rust can do
it, for example.  I do wish we had an __attribute__ that could be used
to warn both the compiler and the user that this was the model being
implemented, but GCC doesn't have it yet.
