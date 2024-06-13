Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FF145FFD;
	Thu, 13 Jun 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299149; cv=none; b=nlcdYlx0eJxwHChuUXDmg6NLa5K1xTwrKy3A8ok8HgfVDNvG5XqIcnzh+qs7XRcLJ3KMm/xMKoIix3cjBMxLSD3aPt97RJpWQoH1GWhE8mvN4MROTitgQYjsVFzUPVD2tRdKeKTL9K3SEp27i/15jeed6YKEl4gOBJAwkuWfMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299149; c=relaxed/simple;
	bh=vyo5JPqBjQqokL5N08Ay4QkIPAz+KsrhBNfZtMwO5GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mChZ7N585f62gVn3XRVDits9L+Br/nJzevOG11UtgRWe5yRfHUEnPcg+XjY8PBrGWAHZaMjxLhJX58SY+c34Ud9OAvBChuv18q2rhDR3hA5o3udiWv8tvXaA7NHMDG7t7BlWh+qXj1VzkDcGLxb7gozMPkZ0n9bYHhjd6viPrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gALb+9xc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gALb+9xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0358C2BBFC;
	Thu, 13 Jun 2024 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718299148;
	bh=vyo5JPqBjQqokL5N08Ay4QkIPAz+KsrhBNfZtMwO5GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gALb+9xcsU6ktLqxXndFAycDyTg1rqbF2YGaFyHNdGiV0X1gPZzITBXqjwyNv4d/h
	 kzLOB0rr6eq91aq4v2CrcU0yn+pnIBqLyQkztrN4U/DWo4EHbzbZXVZWIJUSc9fjDR
	 KodTOJ+frN66euL64i2GuUvbkR/R6S7BrvEVavZM6X2BPquyekXDJ5T0KqoKanOmPT
	 ac1KhcG+Nm7H0X8mV3pWbIufWsmhrOdigWZczRMD7+kSyntWFpZOnnCjjLac82pPTI
	 832phiylLQLJjsKDzjfsyR79GlOaFQnTGvWnIlhV25hqM+4R8m6D2kXSwAfww5i471
	 rTYfWQE/qYvIQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com
Subject: Re: [PATCH v5 2/8] mm: rename alloc_demote_folio to alloc_migrate_folio
Date: Thu, 13 Jun 2024 10:19:05 -0700
Message-Id: <20240613171905.63316-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613132056.608-3-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 22:20:49 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The alloc_demote_folio can also be used for general migration including
> both demotion and promotion so it'd be better to rename it from
> alloc_demote_folio to alloc_migrate_folio.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
