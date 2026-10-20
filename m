Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504710;
	b=gzAl4xOdyzfTcW2BO5qkVQQYtcXwh3/Riu8qXqmugwsY3Ofn/1ral6iMRAzQzWMkXnOu
	 eEwFgKzsXowKzv4IxXsAJi7hwgL8u0mqPcba5gyp/ENIU7Epx160VroSOCS+VZloAgdyL
	 jsjNxwUcDMGEpmR0HdgSm8Lj2XD+tiYQAz+0iQwX8RtYtfTKDBjqgRyHAHhKrjM1bJRds
	 dtNvtLude+SGrnRDC7E7Pg7t/iMV0RbUdCk3x28G8/FQtu7f++mtpchtPwpExNvgQEYPL
	 Uluts/3GtdkUfFcM7oYGDuKj+eS3AP5Yt3GOk37N4oW7H8Fh0R972pXBCzO1Qm5lR8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IBGuiP0nGAo3Z3FpbYxcVYUnONq26JoesatN6Nk3lmc=;
	b=FB3CMpG6KyDHXZd3JTPN09dMLMljXvZdNzAwmiJCpuh/n0rrPAB+a9k4aBCIgQyzsBWA
	 eH6DFPXUprWxfcOvmJONoNiTbKkcwOT6wGbCL79kNkOCMPTy4qtDf3/zJUj5XBSZxWccA
	 +cQ7f00o9IlSrBMBNJiEL5YGpvwkGfHifrFC5guM2La5xX6329Lf8LOaaofyHWG3lk/ib
	 60ThuPF3pQ0o/N2kpTVt+WStjI2hL5p02E9LUdCmcH2UBW0eGHIZV+9MRHnlvK60icf0Q
	 2QMTuHJ+EW+09l66E4o/m4YYjB/06xoxQdmvysPNxAVxZKUKETep2AMtG/cgJBFN/HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFTWJhfX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773C606A319;
	Tue, 20 Oct 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFTWJhfX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C82D1F000C4;
	Tue, 20 Oct 2026 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504710;
	bh=IBGuiP0nGAo3Z3FpbYxcVYUnONq26JoesatN6Nk3lmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFTWJhfXpNhqkTYblYQE3A8qbRavY5KXYaF1+xBzq1BuHNn44ClyG7RVJNYgH5s1K
	 2nG3zF7BQykI5QG858eRRKzmhyerFraTYWkZ81LI38ORlg5Y9dCRRdSKWlKix2TyZa
	 Pi2qKnM/QraAXsrmK34Dvq5Tj6yZMluzp8gAydyP3F0L02aVQxNEmFXWUSW7DqCiEd
	 S+3jj2tUirDxTyehFOpEIG4AfYrrZMGbyw0HEtTs8WoAnAwzfDKcCVY8/F+IpxFAOj
	 9RNiI7hBGls5SxXUxRqnLOAgkh0/3stphXA3E+n5tzBUotz/SSK+s9dPdUcRTDzMZP
	 atu4Lz6Azjbkg==
From: SJ Park <sj@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/reclaim: allow disabling watermarks to force reclaim of cold pages
Date: Tue, 20 Oct 2026 06:58:21 -0700
Message-ID: <20261020135822.85334-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020133233.3920818-1-ruanjinjie@huawei.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jinjie,

On Tue, 20 Oct 2026 21:32:33 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> DAMON_RECLAIM runs its scheme only while the free memory rate is in
> [wmarks_low, wmarks_mid].  Reclaiming cold pages raises the rate, so the
> scheme self-stops as soon as memory looks plentiful again, which is wrong
> for a VMM parking an idle sandbox that wants cold anonymous pages
> reclaimed immediately.
> 
> So add an ignore_wmarks module parameter. When set, the scheme uses
> DAMOS_WMARK_NONE, so damos_wmark_wait_us() always returns zero and the
> scheme stays active, bounded only by min_age and the quota.

I agree there could be use cases that doesn't want the watermarks at all.  I'd
like to avoid adding new DAMON_RECLAIM parameters if possible, though.  That's
becasuse DAMON_RECLAIM is introduced to let people use it without complicated
setups.  We will of course add new parameters if really needed, but I want to
see if there is a good alternative.

Have you considered some other alternatives?  For example, could respectively
setting wmarks_high, wmarks_mid and wmarks_low to 100%, 100% and 0% effectively
disable watermarks?  Have you tried that?  If that works, how about updating
document to clearly explain the usage?  Also, have you considered using DAMON
sysfs interface instead of DAMON_RECLAIM?


Thanks,
SJ

[...]
