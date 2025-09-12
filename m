Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1B54758;
	Fri, 12 Sep 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642783; cv=none; b=N4XxahAdtpMLHn3gxQf9P6ZItIZnsxwuldad/XVAAamAm8GAzlhtYNCUWx3WfvtAkzK2C9prpYi948VGPj+76Jbxoclx/TDUC0N7A9yfI+NG4GZukx3XYM86iqRHNANMvtW/tJRz6sPWbRcyRnf8gBOjCUouBb4gO0fuVEFkOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642783; c=relaxed/simple;
	bh=wEWmhx5I48s/7JlI41mY1TFXvMlPvtQErgtyGu0ct2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZOxl9oqm1mc2ffi4MSJuypP8iHVz6kEvzbVbVy9QYEyGsKibnwLkBN8mdYqQjcz5T+OaoM1WZLPGNLfGJLmjB0wTkesCo7Kb2Cq3k98pr/FYHvCpPQOyzoc3cXR0KyoSCmPaMD7DsiF/iSVLVFAaJ986lcp2fKji24jEVCs6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCPcERYv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCPcERYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FBAC4CEF0;
	Fri, 12 Sep 2025 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642783;
	bh=wEWmhx5I48s/7JlI41mY1TFXvMlPvtQErgtyGu0ct2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCPcERYvQkcQ7m6OKqSUY5DTahcgVHnZj5Wu21LbySTpf/HGgKguvEpe+UxexaNV6
	 huMHYEAVWTdAaGBJ8gXRO3VfSA3IsTGdwE22SpJCNYrdqt0TQsgJiSdLjvuJUvfqmw
	 q2E11V6jLVEemLPo64N1sEE+K0L3W842PgS8TIqDMP7gssBIuQVAzXqhFtkB2LgSuA
	 pF0lemEq/lUbBL4b2J2XQxr3jlmoA5SdliEzyeToqlzttdSUYFOK7AEVWh5d8KrV8V
	 Sr7RJv+2dGPFLHFH0zPi+LHsL06Y4+R193x+APbk9avb7ZRdLN33wLyjCNNpfkQtR5
	 nfvxtPFskPMyg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/2] mm/damon/stat: expose auto-tuned intervals and non-idle ages
Date: Thu, 11 Sep 2025 19:06:19 -0700
Message-Id: <20250912020619.59642-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910040022.168223-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  9 Sep 2025 21:00:20 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON_STAT is intentionally providing limited information for easy
> consumption.  From production fleet level usages, below limitations are
> found, though.
> 
> The aggregation interval of DAMON_STAT represents the granularity of the
> memory_idle_ms_percentiles.  But it is auto-tuned and not exposed to
> users, so users cannot know the granularity.
> 
> All memory regions of non-zero (positive) nr_accesses are treated as
> having zero idle time.  A significant portion of production systems have
> such zero idle time.  Hence breakdown of warm and hot data is
> impossible.
> 
> To overcome the limitations, expose the auto-tuned aggregation interval
> with a new parameter named xxx and the age of non-zero nr_accesses

s/xx/aggr_interval_us/

Forgot updating that before posting, sorry.  The next version should fix it.


Thanks,
SJ

[...]
