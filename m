Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3B3D6664
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560603; cv=none; b=drsb+xSTgRAgFASKWTHnCUSQUEOvL6dt+Vba/eXTZNIxnyOg3lYkDCmJUoZL/ddkFsEmYXFQJ1TutGStmRElYOj5aTdmgThciKlBrskWntu2e9L/wyrckZu544P5nys10WbIHuGhjk/MAmXhqw66fV43ejGxstSwqIHHuoIMxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560603; c=relaxed/simple;
	bh=DDehand84XTzijPnsTs+htwcV1Cmbb757Dl1EsmDkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmsUIliTxlinIjGzzxx3r7XRhXgZkwV93NFCAjmL4CYOVFEtcmBXh5LregpIAz1/pxQv0+5fh9Uv98fA1qJW0mVihPWQmLNFaA2PnQAe5nypFYFcqTRMdsbjBDvF3CL3B3guLKlWGk2g3wv1TCS0YycCyiOsdMUjl2FbKLFMOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=XEpP0FrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ikIvuA3m; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="XEpP0FrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ikIvuA3m"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 809CF1380240
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 11:43:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 11:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791560601; x=1791564201; bh=Aj9UrRCfC4
	ORX2AFQFmPC/gxe5C/DS1Ye4qCAs4zrbs=; b=XEpP0FrTvsyVazMOrGNZCze8Lr
	D8L0HSl58HpSMe/0h18dGudr9nURdzkjdh2fXW+aWpVxPygxndaj5kai/BIYIjUO
	HIsxLwJmqJm4B9fiBWhCgvIXA959KVm4Oik8X2iVvWMgj/22Ik4Dcsz1MVnHVaaJ
	iTeMsbAevoKlKnUQAeTDexN0aXGz42yHjo4ZmCb7SM6FJAgxsYLHZVA4ul3J/0jf
	SS2iLlNon+ldOW+2qrqUW2weg6/SeC8675Iiu/uJMmbRerh1oI89m8eDR4kn1+vu
	5OabcQDd2IEucDoP3JjWyKLHxCs8bLgwD5WVg/teBvAqbvbJqG5q3HU8Vu1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791560601; x=1791564201; bh=Aj9UrRCfC4ORX2AFQFmPC/gxe5C/DS1Ye4q
	CAs4zrbs=; b=ikIvuA3mQ4svYeCPUw1+tNupADyvkcshehblvPl2qv74+zv0Eyl
	lpTOqb9tPTmDdFi7dt+ACjKpHnkvnKkpJjTg5mbrVqYZVOx95Na/JeanGDaMR/VW
	AAQ5STnKIVtQiR+FxXEv2edmqDcSr/mvzi7gU6VVd3B78l5iJAJ4Q4+Gg0Oy9VzY
	e7XUmrZVpEZbolRvWVd59YPCQgZoNkpe5+E5rqDwxxhgOu8PwL8iKGEzBD2u0ziC
	AbATnJxmzrAYLMCoicYVKXGq0fHNeVxdNeUNH6hMGygGGkU2d4vxETDqUbj2OE5N
	9p6m8s9yFm/X3lgh2J/+LPnZSQSRbNWHzjA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791560601; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:WaXFiPpMOSH5mCWM9NC90VH8nX/PVrXhgFkElhxJPR9kyK2
	pp+u6mqCdyN6kPvbUtRW/Kde776ECV+iJNpqzhyGC1Elsx87syFXqlyI6L7LYUKi
	7W81PUnSSR/AvGkG85n9PV5imPA0/2FS/GZh1z+Et7KOSagt7xroqyCZrPM6FDHe
	E2lukwv/w6epSv40qZper35ale3EBHg5rkTwsqJKc1Cn5mmq/6ojK3NhHpRDAee9
	GSHzdPJZ04pTFmJYO4aZCThFNlBwyt66AdcWn++nyCScpaBHKTeyAM8iGQ9/SX+4
	1ikqCm2fGqoq4smmmmh/+0C12yH0njZkHoKo4mA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WJq6pW7ABN48eZYcW6c9nITdcUioh3s5dQ3/0wXPO+s=:DDehand84XTzijPnsTs+htwcV1Cmbb757Dl1EsmDkMQ=;
X-ME-Sender: <xms:mQvJar3akoFrwUKVFGaWiXDlCosFL1Kv4FW7DXYTAnznSyL27Lek4Q>
    <xme:mQvJakJQlvrmp4bD00JhVOrXdhrdVCLZ78SKbkZb4pqUbZUv42r0gYhYlAtzzzBzd
    Q7xxHsmSuR871teV0YKWi_ubjlRwFWJxnaHcJwcwhc0BAfMeN3bL74>
X-ME-Received: <xmr:mQvJarzTzWoqsMs3JIg5kPLSAhwUhObEPYZkuWTXdiFxPQDP_Zw5PEhogg>
X-ME-Proxy-Cause: dmFkZTFP7n4MPUnav3RdIK8H+A+dtxAAXt54vCBIuraeho5WQfeHByTBT4IoaCUtoZhKA9
    xRkgW2ggkExRiY6WPzL2eFX0GkcilCgd2QDboVrZyWPyd5MJncixOoXLA1lp6y+HBajQdU
    zhaYlpnPaQo1g5zFuxvR0o+RMlkOdfpWW9wEG4jqDPRYMbBNYwH5EfY4f1Nz3ehijk10UO
    MHIWoFTu64o2yWqgiHhwJUXO4h8feE//Z3IR6OfFq9QKNxKi1T1hobVl09aJaYDM8DIDY5
    kJI53e2lzHheXiW26gCW5ak2cBIT75HD8GGUWJGHfr6mQFymG43KpLZHWyKHIRaQTFG1nl
    ebrATdBiF8dGTwXUTEpJL+zTIZ8XRyk2fDc+I+CXsKtDplEvlL36LgyKU31RTVw2zSjGQ0
    kB66tXK1EMVeN9fiFVOoC9fk5/+iapTOtMN1/gradK6kQP2/Pdsu4BUI0C54CcOu78LQ0K
    YpoYKeRGYCLFxSFh0ztbPvErhiBrsoITf6QrqdTOArtsqs1YD94UcUPd0lx4PAIqxvJ3X1
    hZL0RpazTnYySYOnijA3YvnJ+4GY/MSNkn3rHUFY1vudZhtMG0aqSPPSX5IaEYP2PUcwCY
    nf9QS6bIvxZMSEc23UKO4VG6Sa+/MY6tRqOPcsWPUU5anbo6LYwXfuEQ3F5A
X-ME-Proxy: <xmx:mQvJaiUKly3qoJANb6WNl-0R9g7vpE7NA-CG4HgpQkrbYvXHLne4pw>
    <xmx:mQvJarhNFSDFgUJIHr651imzPsCgMYB_W3X5J03TxJA8qVqO_yol2g>
    <xmx:mQvJaiCFbndnjjqzg6qKS0LfXRhZzbadkSgXixOkMRX-VR-Q4vefZw>
    <xmx:mQvJahv9Z8en6FZGqn1AKDS9DK2MdE2tQjrLqUhHN4lksl16LwZLkA>
    <xmx:mQvJarQLDfnQvrga8cNkxX3qbq3dp5BWGtJkd5hsNVmfXSgAbCh0DFjQ>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 11:43:19 -0400 (EDT)
Date: Fri, 9 Oct 2026 21:13:17 +0530
From: Suhaas Joshi <suhaas@s-joshi.in>
To: SJ Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, aethernet65535@gmail.com, 
	oe-kbuild-all@lists.linux.dev, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/core: Copy only installed probe in
 damon_split_region_at()
Message-ID: <askIjMr06hNDZpMo@fedora>
References: <202610091039.fhMXCn7d-lkp@intel.com>
 <20261009082154.42336-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009082154.42336-1-sj@kernel.org>

On Fri, Oct 09, 2026 at 01:21:54AM -0700, SJ Park wrote:
> Hi Suhaas,
> 
> On Fri, 9 Oct 2026 10:40:07 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Suhaas,
> > 
> > kernel test robot noticed the following build errors:
> 
> Could you please check if this is a real problem of your patch?
> 
Hi SJ,

Yes, this seems to be a problem. Liew's patch [0] was merged recently,
after I started developing off mm-new. So I didn't catch this in my testing.

I will rebase, fix this up along with your other comments, and send out a v3
by tomorrow.

[0] https://lore.kernel.org/damon/20261006065209.41507-4-sj@kernel.org/

Thanks
Suhaas Joshi

> 
> Thanks,
> SJ
> 
> [...]
