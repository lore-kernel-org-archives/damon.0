Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792950106;
	b=Yl8LjsvbstwsRCJgI9fUfMI4v10kmtylmno2JcXoTxZw+gYojZf0jconbXm3s5IUP77S
	 x6W8rpW+UqMKeEvE4r2WB0OfOaJHo3zFU5gOGWWhGY0B43zGo2vaCRqAqnWu0XMLrSYvB
	 aZiB4qbCw4MScjTVpUR5wywOIiv+B0HKDqgIusFP4nIRvkXIcx35PjkexafcIu+pN7GY1
	 96R81M2TWtp49U4jw0cm83EdrrB3UYXNoUZt7kleNXSSk4Y/5QOD5paSo2gQ50nKVQPqC
	 6zMVcU4ffimFXHvjm5VFTQX3eyLDy7IoVNsizCcEjn/YKl6H74CRmq4iotvUMwI85bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=I2WtUHFl6q3jEaDUWNmi7N1mxbLsBs8YwHkyGeQMjiE=;
	b=B+gBshQx9mPSQERGdA7gFyQfK5ik+Wx7qH/F8thI5cR4XcJNCF5E+/Q8LDfia4tiDHb7
	 41f5WKNYJ3laAb5r9oq9UR9MuC1gL+zNxJ01Q6gIRrwySXUm+7xssbK8q8IrQ1rgaO6EW
	 o5g4n9m1KFb/allQq8dyr6L2UiBnDWpq+cX54/pnecZGE/iz8+/HQk5bNTyXqcQiEc39W
	 LeS69R6rp1Wh94CCahMl6LG3ufXW0G590vBb9dRDIWz6jy99pLTB2NR8wyJInoag9QKvp
	 ZvAGlDQvYDoqtENffjZKTGuW41ZINFyCs8PNkukljmG4EJO5ffx+0CbUAbLun8S6ndw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtTWEkq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36C606A31D
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtTWEkq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CE81F01825;
	Sun, 25 Oct 2026 17:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792950105;
	bh=I2WtUHFl6q3jEaDUWNmi7N1mxbLsBs8YwHkyGeQMjiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gtTWEkq68BRCPoTIMh/xO2jcf7f4SPpTFGWwXwq3E+wsK122kGaF8zXok9jR/4ZwW
	 8jXUegn9aA4my0YZKQ+VoLwvuP1ySGFzRlsL8J/ySPK+lzgeHn7mgyVbnJDY/uq3vh
	 ALqs+4RkE0tlxu4sirGRTyN324EqcvRY3rZoGoZGFSAzSBqX2wi0/64q50XKiX1azK
	 Z3Y26TYLpi60/C9QUi2isC42QrXulVGNLUtcuMbSvW3A3zJqGEkNZOCDSNDdN53i63
	 1L2CLZBqaO4H9ECs5Gyh+6rBXisrCM69tNZyEIBz6Jk2RLN4FfyP9xgrx5prhIcnEz
	 uazf+MjPeZO9Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.18.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 10:41:37 -0700
Message-ID: <20261025174138.165096-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-184295@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 17:37:55 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: incomplete zero target_value check in damos_commit_quota_goal()
> --
> 
> commit ea716ea29282ef733822096401c5c8d92eaaef58
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: error damos_commit_quota_goal() for zero target_value
> 
> This commit validates that a DAMOS quota goal's target_value is non-zero in
> damos_commit_quota_goal(), returning -EINVAL and propagating the error through
> damos_commit_quota_goals() to prevent a division-by-zero in
> damos_quota_score().
> 
> Link: https://lore.kernel.org/20260903010722.94244-1-sj@kernel.org
> Link: https://lore.kernel.org/20260903010722.94244-2-sj@kernel.org
> Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4e6e3d7d0a5c0..8fa788b0d709c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -807,15 +807,18 @@ static void damos_commit_quota_goal_union(
> >  	}
> >  }
> >  
> > -static void damos_commit_quota_goal(
> > +static int damos_commit_quota_goal(
> >  		struct damos_quota_goal *dst, struct damos_quota_goal *src)
> >  {
> > +	if (!src->target_value)
> > +		return  -EINVAL;
> 
> [Severity: High]
> Does checking for a zero target_value only in damos_commit_quota_goal() cover
> the path where DAMON is started via sysfs in this stable tree?
> 
> In mm/damon/sysfs-schemes.c, target_value_store() updates goal->target_value
> without holding damon_sysfs_lock:
> 
> mm/damon/sysfs-schemes.c:target_value_store() {
> 	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
> 			damos_sysfs_quota_goal, kobj);
> 	int err = kstrtoul(buf, 0, &goal->target_value);
> 
> 	return err ? err : count;
> }
> 
> Meanwhile, damos_sysfs_add_quota_score() reads sysfs_goal->target_value twice
> without synchronization against target_value_store():
> 
> mm/damon/sysfs-schemes.c:damos_sysfs_add_quota_score() {
> 		if (!sysfs_goal->target_value)
> 			continue;
> 
> 		goal = damos_new_quota_goal(sysfs_goal->metric,
> 				sysfs_goal->target_value);
> 		...
> 		damos_add_quota_goal(quota, goal);
> }
> 
> If target_value_store() writes 0 between those two reads,
> damos_new_quota_goal() allocates a goal with target_value == 0 and attaches it
> to quota->goals.
> 
> When starting DAMON via state_store() -> damon_sysfs_cmd_request_callback() ->
> damon_sysfs_handle_cmd() -> damon_sysfs_turn_damon_on(), this branch builds
> the context and starts kdamond directly without calling damon_commit_ctx() or
> damos_commit_quota_goals():
> 
> mm/damon/sysfs.c:damon_sysfs_turn_damon_on() {
> 	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
> 	if (IS_ERR(ctx)) {
> 		kfree(repeat_call_control);
> 		return PTR_ERR(ctx);
> 	}
> 	err = damon_start(&ctx, 1, false);
> }
> 
> Here damon_sysfs_build_ctx() populates scheme->quota.goals via
> damon_sysfs_apply_inputs() -> damon_sysfs_add_schemes() ->
> damon_sysfs_mk_scheme() -> damos_sysfs_add_quota_score(), bypassing
> damos_commit_quota_goal() entirely.
> 
> When kdamond subsequently runs kdamond_fn() -> kdamond_apply_schemes() ->
> damos_adjust_quota() -> damos_set_effective_quota() -> damos_quota_score():
> 
> mm/damon/core.c:damos_quota_score() {
> 		highest_score = max(highest_score,
> 				goal->current_value * 10000 /
> 				goal->target_value);
> }
> 
> can this still divide by zero if the race occurs during
> damon_sysfs_turn_damon_on()?

Nice catch.  I also just found this issue while working on 6.8.  Same issue in
the patch for 7.2.y [1].  I will withdraw this and that, and work on the next
spin.

[1] https://lore.kernel.org/20261025172434.161597-1-sj@kernel.org

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261025172712.164385-1-sj@kernel.org?part=1


Thanks,
SJ
