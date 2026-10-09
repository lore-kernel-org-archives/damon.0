Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61E3E764C
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549962; cv=none; b=s53hdoFRMIRXRPTg/6H0IFFaYCVxLJhVVr3/Icy49CADV7nWUo1Nx+6qIO5RUKUGhyUSIazqMnjUn8XRD3GazQ/Edsai/PliWS0NoUVNMkmoeCBByS4qNhwttUc7I6TQloT/y/sJXBGS0SgQFmJtwBZspvo7CkLrsqoxhhiEtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549962; c=relaxed/simple;
	bh=wgN5bYEWAoKe2F+VU1WwfU1v0X1eOQrIcMP5i66YyL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFDAQ9VsAVjn+3zfAjefVUeKwcGPe+q5uRtZjSktJ0QJ7xswiNEV57x/K74Y1yDPlH6yJ1wh5NlRy4Y8k+px/jxEiP0NOJAFJJdyWo9cGyKohknDVwRyYNY2RxYnCMkvNo/0yXuf7NvH/vG7mSH0s7DFDuoEL0LsgV99wjT07Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nIAKcm4E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nIAKcm4E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fgixxsqwaATihbPk/CkvSOE/LALNPeYn/vk/XmJ+1xQ=; b=nIAKcm4ERKAlzvT5xAnorMTsuo
	GHrrvWqqhnPWRcpKJtwmt/t/2to5cUNdZ56sJjxQf3V1bHv1Auoo1zszZCU3V1soLela1D/4GeDMd
	+L65G8IDugGDzc2dsTgJs/7SIkSXJ3Rk4buktEcui7cPdwzoKSuK5CXOaVvG+ZZ6gbrUQXuOEu4NU
	Z6bvwmTM/SL24mJ57CFVkrJZaHxwtMDcukxSIRMpYIDQZa1R2lCYwknWHVc8XZj+E5uR/NRC8+gsx
	cos7SonUWLwg3x4qSlDohQdXnES0x5lKReCRh7tSZJOK8BvokqoFzFG+Tu+2yf+gEFw4UA6TPrJcg
	jqvX+kvA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF9yv-0000000EmdN-1xf2;
	Fri, 09 Oct 2026 12:45:50 +0000
Date: Fri, 9 Oct 2026 13:45:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Arnav Goel <ArnavGoel@woodstock.ac.in>
Cc: "damon@lists.linux.dev" <damon@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Research use of =?utf-8?B?RMSATU8=?= =?utf-8?Q?S?= Linear B texts
Message-ID: <asjh_RkmMyEUZUiP@casper.infradead.org>
References: <SI6PR06MB74745E4D61CF3341BF6958CEE7922@SI6PR06MB7474.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI6PR06MB74745E4D61CF3341BF6958CEE7922@SI6PR06MB7474.apcprd06.prod.outlook.com>

On Fri, Oct 09, 2026 at 05:42:41AM +0000, Arnav Goel wrote:
> Dear DĀMOS team,
> 
> I am a high school student in India building a benchmark that tests decipherment methods on short-text corpora. Linear B would be an ideal real-world check, since its texts are short and its language is known.
> 
> I understand DĀMOS is available under CC BY-NC-SA 4.0. Is there a way to export the transliterated texts in bulk for non-commercial research use? I would cite DĀMOS fully and not redistribute the data beyond what the licence allows.

I'm afraid you're asking the wrong people.  This is the Linux DAMOS
which is a Data Access Monitoring tool.  You should probably be talking
to these people instead:

https://damos.hf.uio.no/about/content/
