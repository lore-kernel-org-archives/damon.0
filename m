Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18354346FB3;
	Sun, 12 Apr 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017429; cv=none; b=nANM2ohn0xCvGcit258imgHBWhWnyqCvnI5GfjkFEGpBjrld/mf7ac1tGLP39pqdvEVT/3leDtv/CweJhRAhRWpBGkxtDobxPYeckDj7I96Q1r32G1m97RNuW08UEvcZ5UDcRFeeQ9NEFoJkxTqaCgAKOMoA9TtD57qbKkaCdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017429; c=relaxed/simple;
	bh=9iH3qkwImK1/O+QefkDCqpV04KGR50w7LLCmPpXJW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVQkz47LdcY0GW2Wz8tzcrcUln0imH2MrRPOfH3gJdxeRuCemlFLoMug68G0xrIP6D14D9RMQn7FUOfcjKYAjsmARD8pxf4SIQidaOvMsARjaUi/uy5GuaDRPKNdSA/CajpRsztuSXSDoShC4gEiHhXqiXt/gB5nAQSxXWSj0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNmJw5jd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNmJw5jd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8746CC19424;
	Sun, 12 Apr 2026 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776017428;
	bh=9iH3qkwImK1/O+QefkDCqpV04KGR50w7LLCmPpXJW9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNmJw5jdueSCOXs7VUrUkiY8QVH8oJ/A9q7fVqcNAn38Gv0nmsTsKkeAe7GnPulgk
	 5WODFQgKijbNrPHdEmEk7FGoOEBEw+W0ixwvTb22PjX/dh9r90UnLNis1aLxEAJJcI
	 Q+FPcMpBqKvOibqbE63qEH6LKh1iPYN/rrZF/onpPfAzeSUds7lpY5rwJ1XId4v4zT
	 GlIhbb2fz1XmmG1jsp31ZWH7HRMrWbJ2eCosZAQrFdYu5tfA2q3+MDaLSau9J6T/jT
	 ZV72LwuMwwIW3Pf5G22EKzac+fALyOoSrSkxUWGgI34RSgMmCj3tZiPH68pv/uCvJ1
	 5ses5Y/afSkOA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	sashiko@lists.linux.dev
Subject: Re: (sashiko review) [RFC PATCH v5.2 07/11] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Sun, 12 Apr 2026 11:10:20 -0700
Message-ID: <20260412181021.84296-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412161957.82835-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: Sashiko found no issue but hallucinated.

Forwarding full sashiko review in a reply format with my inline comments below,
for sharing details of my view and doing followup discussions via mails if
needed.

> # review url: https://sashiko.dev/#/patchset/20260412161957.82835-8-sj@kernel.org
> # start of sashiko.dev inline review
> commit 4091d558c881126aba4445ec7fa5033266c62c55
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/ABI/damon: document fail_charge_{num,denom}
> 
> Update DAMON ABI document for the DAMOS action failed regions quota
> charge ratio control sysfs files.
> 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > index 2424237ebb105..213eb87392d88 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > @@ -322,6 +322,18 @@ Contact:	SeongJae Park <sj@kernel.org>
> >  Description:	Writing to and reading from this file sets and gets the
> >  		goal-based effective quota auto-tuning algorithm to use.
> >  
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_num
> > +Date:		Mar 2026
> 
> This isn't a bug, but is the year 2026 a typo?

Apparently a hallucination of Sashiko.

> 
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	Writing to and reading from this file sets and gets the
> > +		action-failed memory quota charging ratio numerator.
> > +
> > +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_denom
> > +Date:		Mar 2026
> 
> Is the year a typo here as well?

Ditto.

> 
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	Writing to and reading from this file sets and gets the
> > +		action-failed memory quota charging ratio denominator.
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260412161957.82835-8-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260412161957.82835-8-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
