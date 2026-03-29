Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E942874E6
	for <damon@lists.linux.dev>; Sun, 29 Mar 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797141; cv=none; b=L/Ga1KUQbLawg0wiTN8fRxSQ5BiVc0//1C+dwlKueQHd/Wm0dCLkAxc/GrydOJX5s2T3rrRtes6XyRroIXWA14QNGsUczxla4oln+NI6pe8R62AlStobi4xRyPV6zkfB1+xr8vI4LPjkp19wsTQjsrTKwXmo087R4K6FpQvGKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797141; c=relaxed/simple;
	bh=9hextLtkAfjK6hXZX5ChQd5LrsN03XztqpNRxzi++H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMCiEZ0YCBT3Z2it+2DEnUjbEIMsnpjJaEdMoRJ87RIVyI/znl99T/Eo5s+jNVdKuV9+9ia1ctmFDcCr8EgGsyhg/oZJvQK8dmmStafo6gExXu1mhDfQPu0YJXc2OSDjX1ANo36V2u162w0N6ej6yQWJG0tmrsEEIrzouLOgZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4T93kwb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4T93kwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00020C116C6;
	Sun, 29 Mar 2026 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774797141;
	bh=9hextLtkAfjK6hXZX5ChQd5LrsN03XztqpNRxzi++H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4T93kwbCo35X+oPgNmpQx/wx5boeQERvcZ+DQfyBj6bYfxXusrxZJXmV8KES8j3e
	 ZuyQKCObwbUgEcB4zs5MU7ONT5sujNKGwKsy563/x2qGDN04XiwkXA44VHFnWlwc2C
	 LLjTBlKTLTe2Z9LYTNirgNkeBJ2E8K4ZmJ2w64/RVwWa68331l1jWlsvI2vtqGz8Dt
	 IKNyrkqatz8iTqpoYhWGy5rQLJpOWR3IMQQpoxDM1Xbyx7UEwxXjILV22XfslUB/0D
	 IKYBsI3D7zPkIokzMVnR/vX5TJMA3629txKm02Da6RDkX4SviQs8J29F87kbjv9/E2
	 +4mA/LO6y4pxw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon: add synchronous commit for commit_inputs
Date: Sun, 29 Mar 2026 08:12:18 -0700
Message-ID: <20260329151219.44003-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329075415.36775-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 29 Mar 2026 15:54:15 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
> silently (no error returned to shell), because the validation happens
> asynchronously in the kdamond.
> 
> Solution
> ========
> To fix this, the commit_inputs_store() callback now uses damon_call() to
> synchronously commit parameters in the kdamond thread's safe context.
> This ensures that validation errors are returned immediately to
> userspace, following the pattern used by DAMON_SYSFS.
> 
> Changes
> =======
> 1. Added commit_inputs_store() and commit_inputs_fn() to commit
>    synchronously.
> 2. Removed handle_commit_inputs().
> 
> This change is motivated from another discussion [1].
> 
> [1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

Note that mm.git is nearly closed for non-hotfixes until 7.1-rc1 release.  I
will add this to my tree now, and resubmit for mm.git merge after 7.1-rc1
release.


Thanks,
SJ

[...]
