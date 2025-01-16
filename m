Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C81547E2
	for <damon@lists.linux.dev>; Thu, 16 Jan 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054443; cv=none; b=oB/dNpXZeQ6JNfDRcXrr5mtRLqSlb3w6UQFqUM7mIORUSgB96STn9aoKlmKFmDT5UXaWkubulvw4JMVq6SJNn8a6O3zasi07uoj7bQ8W2y1G+Bi+QffSy2A0VtJ5EvfVc5aewJcAEz3fhGf1zMcu87W8S5N/glvpmUQdskrowgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054443; c=relaxed/simple;
	bh=G48xEGLo0N9B2iHCJwaMO2iArP7gBycxWmnsdp2VJkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFpq9KsTRgJP5CM76fJ4nkwttnst6sWGOMPZgZec2SnHHN3b2YRAccezQKsHX+Fhvwf50sWSlse1X6mSsfPBxRH2Kika1gHLQVv6s61PbKJH+7apkQgGSsvxWx1UhAi0HsHtUr3FL0O936c863yrS3szVximvleBkiJceES7aHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX6WcNlN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX6WcNlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652CBC4CED6;
	Thu, 16 Jan 2025 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737054442;
	bh=G48xEGLo0N9B2iHCJwaMO2iArP7gBycxWmnsdp2VJkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iX6WcNlNwgehIbp9M58MIhvGaAlnSIVrDCosAxCUhozOBGO04bpQhwgekrlm3Wog+
	 TQnmRi3fPJMxhwuhOoXQnpMjdgNfdmPmyAWeFM1Hbejzhr4ELqYB9N2l5c+xGx+KCo
	 djfECx6X1Ib3XYif7wzglO5VyhphtrH6rFI9B/d8XtPgwu/FYRxQ9a+19bH24Aznxl
	 JPCPJUdgQ+o33Y5+ggWFZ6KE0WAY/Wp9IcHWKaKVN1OUX4uasYTnQ/2MS/1EWej7Ir
	 Li7JbutnWoPUSab/5qesRHide8qp9VgUE2Hxh0YYi98EAdP4mN54x/PRNGeWioTdYF
	 UOoSixHj3j5Zw==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [v1 2/2] mm/damon: introduce DAMOS filter type hugepage
Date: Thu, 16 Jan 2025 11:07:19 -0800
Message-Id: <20250116190719.60415-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <bae5af92-c050-47f3-919f-ed3bf1c485be@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Jan 2025 15:15:21 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> On 16/01/2025 14:44, Usama Arif wrote:
> > This is to gather statistics to check if hotest memory regions
> > are backed by hugepages. This includes both THPs and hugetlbfs.
> > This filter can help to observe and prove the effectivenes of
> > different schemes for shrinking/collapsing hugepages.
> > 
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > ---
> >  include/linux/damon.h    | 2 ++
> >  mm/damon/paddr.c         | 3 +++
> >  mm/damon/sysfs-schemes.c | 1 +
> >  3 files changed, 6 insertions(+)
> 
> The corresponding DAMO PR is at https://github.com/damonitor/damo/pull/19

Thank you for taking care of the user-space tool together!  I will do review on
the PR.


Thanks,
SJ
