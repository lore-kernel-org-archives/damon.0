Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CE1A254C;
	Fri, 28 Feb 2025 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780576; cv=none; b=q6oizQmcDmpdocf1AznFf8Nkhpx5GfzLznHg91SJX4N0CatfHthbN/BNvcBQfBuLrVTeq/cK3pu4WoxSWgdgrCc1wxIxiUsXKaUUyD37/cEuvtG+dWUepDPz4U7yFiKJLPbSwlXnbazcKYDYRDcB4lBhZzdESIFjXM2wqzvsVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780576; c=relaxed/simple;
	bh=GkIfcQPKP+rNfXmQzBlmCYKlx5Vw4LcFnlqzHPTotfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e09ywK+dE+MFuP7kgsl2MW3aIJJHtNwcHkr6J2j4BlVJBdjVHF19RVqSegpP5Y0P+yft1LRYoApdAkYg0ZpsOl6fnJCj/NGKvcY50KghmqxC94jLQ6X+RtknHxbMx3hiyUv+sXuVaXDpHr+iCmf/zKxgHJ2RSRZfmfMFFcq9tgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLL3tGHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLL3tGHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC0BC4CED6;
	Fri, 28 Feb 2025 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780576;
	bh=GkIfcQPKP+rNfXmQzBlmCYKlx5Vw4LcFnlqzHPTotfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLL3tGHb5kCCz68Qaghi6BzSATWGmAOtRKgOwxvfHTZHXVaqQzjFqhxnJkFUpPzfR
	 /wm9Z5991omNsHbC29eEQdFoMkQlOe3g6toTu3uzL1uLWQMbFm96baQSJy9QiZ8A0i
	 fjNQNxMVVF/XSRcrQ2IIYwCVsSgdMxel4S25dC9t4asQkyApHK9AnyfXPnjBlEI873
	 gHZ3cIjQGancQ1da7JKul/2upWisylp/UXJf64p8K1d4UuwCR5EgTa2jvAv8m1vC0e
	 oj86Ay8ftWej0C+Ewsir1QsPGGWWPX/kwnbgU7XgUtzlkPOgrviop6C/dYLjOuO1pR
	 l+j5p40HNYgcA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/8] mm/damon: auto-tune aggregation interval
Date: Fri, 28 Feb 2025 14:09:32 -0800
Message-Id: <20250228220932.50419-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Feb 2025 14:03:20 -0800 SeongJae Park <sj@kernel.org> wrote:

> DAMON requires time-consuming and repetitive aggregation interval
> tuning.  Introduce a feature for automating it using a feedback loop
> that aims an amount of observed access events, like auto-exposing
> cameras.
[...]
> Evaluation
> ==========
> 
> We confirmed the tuning works as expected with a few simple workloads
> including kernel builds and an in-memory caching representative
> benchmark[1].

Forgot adding the link to the benchmark, sorry.  It is
https://github.com/facebookresearch/DCPerf/blob/main/packages/tao_bench/README.md


Thanks,
SJ

[...]
