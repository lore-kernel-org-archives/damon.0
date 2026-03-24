Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C7332EA0;
	Tue, 24 Mar 2026 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312887; cv=none; b=cuZODA5VQ/xADxRKk9xlOAvm2ernsto7v3tHWEJnHFY9nJymUVkw93h2msq2sNGjHxK8V/2yek2xQzB0iOfXQBAg6n81cDBLAkcvGUg4gFMhauFWyPXtlDXA/ShL9awVMVrU++mnBmVtzbOBY0nDPMgs0fQQbC8La9HMpZCudjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312887; c=relaxed/simple;
	bh=4hnECM3pbJTu033bzgEOZQoGWKiwaOeCir1o+EZ6ulg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObOhutRUhLBX4MIAD3LSwumre5YmVGcyjMhp0If6n4Mjzgzh2moTHYgYGIaUiuVZUpYarAICXT7UwZS5HSY6JDDPJ/tEJPpYbOZ2H4cpraJqJguD/GKaBlt26JwSkZ8X5T+/6IEvCqU3YSTYqFMcsJeQlVf04kA/q/wBsEGvhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiSq9kQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiSq9kQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72610C4CEF7;
	Tue, 24 Mar 2026 00:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312886;
	bh=4hnECM3pbJTu033bzgEOZQoGWKiwaOeCir1o+EZ6ulg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiSq9kQSVtMd0yzuauXv6D1q4ha5XDneI11eKY+k8lZjSuXM/ZJAYas0Q4LJ/In/T
	 omS5g1UA5HlPlxTmi4Z4VrgujsPD7nPvkuVIOflZd+drcvmfQRluE4OX+yYCJWx5Yi
	 QSQElOnKKenTXKk4QuQv3d58REpZQbMlTxJjdTCTtLQ1WiHaf5x2sgSt4wMY2mPdMS
	 NWTUKwcaOJb/nxPrwrcoALfMWGuZfIW+0JRutcOvS8ojx8nG7xCxIINIxlc3a7Lx6g
	 X/JmO8O1N7begxMajzfrHDDphDkX5RG4QUUdPufSJxekuUT/CQJpqLZWZyFQcP23Qq
	 s/F+nOHSw5G5Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: gutierrez.asier@huawei-partners.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko review) [RFC PATCH v2 1/1] mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
Date: Mon, 23 Mar 2026 17:41:18 -0700
Message-ID: <20260324004119.87026-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324002936.86653-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 17:29:36 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260323145646.4165053-2-gutierrez.asier@huawei-partners.com
> # start of sashiko.dev inline review
> commit eaed291e6fae91842b1836c68bab867d53525db5
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: support MADV_COLLAPSE via DAMOS_COLLAPSE scheme action
> 
> This commit introduces a new DAMON action, DAMOS_COLLAPSE. It allows
> DAMON to synchronously collapse an address range by calling madvise
> with MADV_COLLAPSE.
> 
> Link: https://lore.kernel.org/damon/20260313000816.79933-1-sj@kernel.org/
> 
> [ ... ]
> > diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> > index 3aa5c91548a5..c6476e63f4fb 100755
> > --- a/tools/testing/selftests/damon/sysfs.py
> > +++ b/tools/testing/selftests/damon/sysfs.py
> > @@ -123,11 +123,12 @@ def assert_scheme_committed(scheme, dump):
> >              'pageout': 2,
> >              'hugepage': 3,
> >              'nohugeapge': 4,
> > -            'lru_prio': 5,
> > -            'lru_deprio': 6,
> > -            'migrate_hot': 7,
> > -            'migrate_cold': 8,
> > -            'stat': 9,
> > +            'collapse': 5
> > +            'lru_prio': 6,
> 
> Will this cause a Python syntax error when executing the selftest? It looks
> like there is a missing comma after 'collapse': 5, which might break the
> execution of the DAMON sysfs test suite.

I think sashiko is correct.  We need to add a comma.


Thanks,
SJ

[...]
