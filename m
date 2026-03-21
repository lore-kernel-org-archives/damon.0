Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFCB46BF
	for <damon@lists.linux.dev>; Sat, 21 Mar 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114363; cv=none; b=tW91gdN3Rb4S24fJD1MOe1b2EKYWNp2La+DQXsBCsrWfOd9aWjOnKq/2/ywhPL+YOHFFNpGh9nnll9KQdlxrT0f++yhHlrQwNaAxAviNVig9OjZBfM0kY8PwrK/9ssKN5HFQ5/mMOSwZZuUh14Bjj2LL4RhitiBpiHwbJWYUJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114363; c=relaxed/simple;
	bh=RNtipWs1kS4cmDdgnR52UVmE1qLq9rRjhULJrIQzKkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIssTzNAOs3PXdGpoLKdNNjQUWDorhAD1IaQaFhhIctjnSMKEbMBvhUfSy7t7Ytf3fR1SdUagcjfXEFZ4VVpGZnh7a3pecU9G96vx02qXHFHuqGpqVuCCGtkl1ZPsiCJ0uTK+Pgw40aB20cLoqg7o2Nj/XSSaShyBSYTM3OXe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOdvYMJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOdvYMJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8882FC19421;
	Sat, 21 Mar 2026 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774114362;
	bh=RNtipWs1kS4cmDdgnR52UVmE1qLq9rRjhULJrIQzKkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOdvYMJqLrVMWECCrNBOqMvSded8Kcxo8XcdOsoY1/IxTgooO88jBn9XSq7JK+vLk
	 3Yi41+VOgV55+fC5Drn1Inq08CmdTu/MI+Wr1P8I4qNkezrk7/HmoQVzZFKODOdzHw
	 UKO+0Uk7g54QTWwr8JI9AmeboN8MLYbY+E772XERQd65RUf2ujyNMK4VB/Bc9UpreW
	 2XG4RXsYjfHQaB/83kmXFGFITKJQ1ajpHcWlBynxdOOi4hRXDbXr4P75vGcDs/Ldnk
	 NTImUGgFLftCl+hRMvMFNje4G3bg1Cj+++uL4GBr78Q1Cu9K5pmb+WllD0SOGyyH5r
	 4JDBpW2lbjLxA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v2] mm/damon: add synchronous validation for commit_inputs
Date: Sat, 21 Mar 2026 10:32:34 -0700
Message-ID: <20260321173235.84923-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321140926.22163-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Liew,

On Sat, 21 Mar 2026 22:09:26 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
> silently (no error returned to shell), because the validation happens
> aynchronously in the kdamond.
> 
> Solution
> ========
> To fix this, I proposed adding synchronous validation in
> damon_lru_sort_commit_inputs_store() and
> damon_reclaim_commit_inputs_store() before setting the 'commit_inputs'
> flag. This allow users to receive immediate feedback (e.g., -EINVAL) if
> the parameters are invalid.
> 
> Changes
> =======
> 1. Added damon_lru_sort_commit_inputs_store() and
>    damon_reclaim_commit_inputs_store() to handle parameter validation
>    before setting 'commit_inputs'.

Nice idea.  I think we could do even applying parameters in the callback.  It
could be something similar to what DAMON_SYSFS is doing.  The code path for
doing that in DAMON_SYSFS is, state_store() -> damon_sysfs_handle_cmd() ->
damon_sysfs_damon_call() -> damon_call() -> damon_sysfs_commit_input().  In the
damon_sysfs_commit_input(), you can show how DAMON_SYSFS validates input.  You
can also refer to commit 4c9ea539ad59 ("mm/damon/sysfs: validate user inputs
from damon_sysfs_commit_input()") for more details.

> 2. Added damon_validate_attrs() to centralize validation logic.

I think damon_commit_ctx() is a better way for validation.

> 
> This change is motivated from another discussion [1].
> 
> [1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Because this is an RFC and I have a high level comment above, I'm skipping
detailed review of the code.


Thanks,
SJ

[...]
