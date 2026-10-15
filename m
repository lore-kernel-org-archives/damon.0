Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED953C3B8
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077361; cv=none; b=V/sA9AlyAxDOpAsU/D5aGEMXEXB7+gZv1wxgV34htbIUIwZtApGNLybHNjUzDCxxtrjpi9wmondqDcavuyWovDHp4M8Bz1zix5okOkvpqlRp6wljTlVprIdSKuyOz247LAiycXwUwQ0RwQhKfJBYL8f0yfy1/Ifk7fhz1a0KAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077361; c=relaxed/simple;
	bh=dyEcVD1Y3vcGMbvRYZPMcBuG39NEenS/76iBFF46FXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPDZnAU/m3ICYmrPAXlM3HKwU8JOXqlSxmKFRfE5u2pWXyRTIVXh7Wo5FbUQhUpk902YnDi6feisSxUoPPcepgpYP4g/iy0NEq7UlJCA5QsmJ04xUBRowYvCPwLjCcl+i8jl8Y4Mw6voz63+vpWvXuXwENrDWcuMFQXZw/WPjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=UFTYFfoG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFYxFynu; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="UFTYFfoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFYxFynu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id C58F213800E8
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 11:15:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 11:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792077358; x=1792080958; bh=rwP/VSpgER
	uSmU7CAJ/qc9G4ynusNvA0TtZXr7xxgio=; b=UFTYFfoGhsTq8HiIpIXIpNZPm6
	7iA74E0cc8cA2Oj+QhqNCvF4FgW+iDBAw3s9cicX/vB2wMODmrZoeWBNT1iYzOPA
	WMTDLuw5VncYTEPnlWYi7YHOkuTgVbug+4iPJIQgTKryfSwXd3sTRQomQ8NXqTnF
	WFNKWF6sYeTs3fP72BHvtyHsnJ7dfe9nud2bkSrEsGbj9S8CEAPaNb3h88vivQ3m
	8y/4vE1zUCRBus5Ch+I5kpg6/Z+QE1sGUw3g1z9DB5TDlYI0cAUVCZM9Ukaz25dY
	AK7hMO7pTukGScpL3v/MAP+GnIn5PDpfKzDYY4vuQGFHOh/NbcbMaaN/V2yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792077358; x=1792080958; bh=rwP/VSpgERuSmU7CAJ/qc9G4ynusNvA0TtZ
	Xr7xxgio=; b=UFYxFynuS5VFEDgpEddigeyPZgsp3YlH2/EPWt8kF8H+mtJzeMp
	V5bNAl4mDNCk98UOmR+dbTa+UU0BwofacpEXfECrfeWf0DXafZkeeySWmRT1Y/VF
	c7/KUMRJ+rAaFQWI6/S+QVwPGIU1gCjQ/WbwH2ARxfxDuswpOoq28E6fEm0MTaaI
	1cDlUXXVz34/yQ/w8PgGna0uMEgFe/yuP951VvIWiNKS956zCZ++0/c+Ly51R7n6
	m3LbLQVsSU2IYLBl9k9P9h75MG2rXIfBYb+zhDaP7mHPJ9jkl4HTJdpPUf2BS7bv
	ijFINFebCHny/68yn3AHSa3Eo7JRmPNG8Kg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792077358; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:dNUNCTChNrrHaQWwITgtQ/l+lbM8bP+MwS8eba1jKybAu+A
	paj81OMVpZVHaI4G83DHBKcgrBwgaxqpzTlHs8ASEBodpzwVvDvO4gtiHImUVJ8b
	l7Tj+bGhDmFZihMrIPfMmInW9xU+on61JcdIa2EkkJ6P0fIu4t+7s/uye90k4iRG
	Wa8PLaT+VLav8PBWl/KwCny/VEmW0+T9AJpsXPIhoSjEQ2kjGDOPdXOKKC8qxcAB
	4DVwwbsZF92irFAYiAbz/bQd774d1ot1xTlSiW4XkoEilFDLPHWi4Mbdkr6c0W3l
	FXWy73oZ71DkrLx/kngMxen5NWuFcX58uZG15qQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LevM5tzYYaumburSvV64b0N1TAhZSGBxVKsiouv4ydQ=:dyEcVD1Y3vcGMbvRYZPMcBuG39NEenS/76iBFF46FXI=;
X-ME-Sender: <xms:Lu7QahPSbuoSEa55WNF0bRmYpBOR56OACjbIEWk3JNCTKXr8S0dUHg>
    <xme:Lu7QatTzXWkm548AYtQ7k520gnsMpGDOvcTx_I_QcLOtHaNftYaxBmwakPDW73-u9
    BEyGgAvDIBt2WxZn4iiNtafI9vClk7WhgFP6Bgh1sDyWgIHAaDhUjQj>
X-ME-Received: <xmr:Lu7QangY90ueWEFwxkeM7vD86KwGJvyb3mjSEBJtLDvDuvktgtHGf6KFCg>
X-ME-Proxy-Cause: dmFkZTEV6GHuCH6/QILcFaKhduef3gBBREJE1psiKhqNhihAbWJpVZhLJ+hjcHxwMmFgu1
    1ywxKhp44j4XcoW/5YOxKZnHloAZ6M8EZwTLdraBuWX2IMO5Y6TSrd6AfBpXSCzQKx0D20
    mwzR80Oay3a5lk+she7Gco8OasTS0vQFqoFCydIfg8lChTL3uvKIEoEIPz1LUoznhNFGPi
    euXxgmiGPs/xOF9xmJXkNWGmwuXMXr6Jl1lUTmw1dSQTE0IhQhP4dm2absUAt/BJ8VMv+G
    drJAHy/HDfSKXmi6mvi/gRtLW+8vgafJVm7rABfv1x4e7cGTnMUk/dq+zXc75QDcbOS1Mr
    o3pOAy7W9oVK+dD+zGy9o7hKIHamLw4WlZLV+O9MMoVwW9+QQ0Evih45zy4quxiSBKObu+
    FuXs/cmZyu0fhmOTivf/u6OOA0Q0g/ZkmOhspMMwstiZUcMc29sU9OMnZlKn+l5UkiQaIi
    27bQ6K0rcuO0QbDmGHGDZiGg/iCM96A1d04T5LS9lXXuflz5/V1u3EeVLdyCXR1KxZTgNX
    dJ/2e4O2SFGRnXxfBxagMFtS/9USPCQGXjM22CKQ9IkJakcNVYld+tfBESGTw+b3sPCLyb
    rTnrQD0L6pRndK3SbZnuEGyiA3aRAsIZ7CqPryk2YBmZA4vMrZLXABubd8eQ
X-ME-Proxy: <xmx:Lu7Qau9ZAYYCGJwm5unJr0RsqICmZMM7FkyyszqFnXcKdVGHfSpBWQ>
    <xmx:Lu7QamF7vH0XnEWYj2C3XXfw34gVVfP5ie2vK5e4F8amLVaUxX-56Q>
    <xmx:Lu7QapmyU7qgp08NfXPvci4TUSvinip5aAploGIzhkXltUA9-mVpHA>
    <xmx:Lu7QaiZdaMYjNtNKqYUbs0njf4nW1nVERxBWBaavg-O-4LriBmrdig>
    <xmx:Lu7Qasn1_OxzwpJGarX3m-fKGxT_WOlJ-T9a131aPlVJUMF60VIS7-Mn>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 11:15:56 -0400 (EDT)
Date: Thu, 15 Oct 2026 20:45:48 +0530
From: Suhaas Joshi <suhaas@s-joshi.in>
To: SJ Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, aethernet65535@gmail.com
Subject: Re: [PATCH v4 0/2] mm/damon/core: Iterate over installed probes
 instead of DAMON_MAX_PROBES
Message-ID: <atDtNpEiy96Lbna7@fedora>
References: <20261015135533.18761-1-suhaas@s-joshi.in>
 <20261015142933.105760-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015142933.105760-1-sj@kernel.org>

On Thu, Oct 15, 2026 at 07:29:32AM -0700, SJ Park wrote:
> On Thu, 15 Oct 2026 19:25:23 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:
> 
> > Hello,
> > 
> > This is v4 of a series I sent earlier. Please find changelog below.
> > 
> > There were two "todo: " items of the same nature in mm/damon/core.c. Both
> > of these suggested that we should iterate over only installed probes while
> > updating (last_)probe_hits[] during merging/splitting regions, instead of
> > iterating over the entire array, which may have empty/unused indices.
> > 
> > So this patch series does exactly that. It replaces the for-loop over
> > [0, DAMON_MAX_PROBES) with a damon_for_each_probe() over the probe list of
> > the context.
> 
> Looks good to me, thank you.
> 
> I applied  this series to damon/next [1] tree.  We are now quite close to next
> merge window.  It may better to focus on making mm.git more stabilized and
> therefore ready for the next merge window, rather than adding more changes that
> are not really urgent.  I understand this series is not really urgent.  Hence,
> Andrew might not add this patch until next -rc1 release.  In the case, I will
> request adding this to mm.git after next -rc1 release.  So, no action from your
> side is needed for now.  Let me know if you think this is really  urgent.

No, its not urgent at all. We can wait until after -rc1 indeed.

Thanks a lot to you and Liew for the reviews! :)

Regards
Suhaas
> 
> [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees
> 
> 
> Thanks,
> SJ
> 
> [...]
