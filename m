Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAA44BCB5
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455862; cv=pass; b=nBHUe8d0XNZBCLYupFeLJkJhV6rOEEtEY9s7+ueAo2yHPhA0875Y/zk0PgL/DUYFdxS4/VICAEUstSH7WgiMsozroqwebERZpyYZIlM2jtPwS4kiV39suYq5Am7vH0HUrhhb+9AjhG68dXHpUgIEmGg1VjYsoFDvT66p//xwjEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455862; c=relaxed/simple;
	bh=bYYVgBnGPKY5m2bD0aoFpeUEfd4ZsBb5Sr3Pzz074UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wd7fws2do/KCW+tssZw4WWDm4CB9Vr9qlFtI9WzsiEVfGam+h6q099MWdyHuub7lGXy7oi9xJCnktvgTCrDYnEJ0WaqwxDS1CLsJfTIVrvYy87fwXwD7LA0d38LNY6v4hVRAerpZTIr99fjgnMlRA1mVKNIlc/dYtgCT2wXGIZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bINwWn5r; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bINwWn5r"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49e6deb520eso38488385e9.0
        for <damon@lists.linux.dev>; Tue, 15 Sep 2026 00:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789455859; cv=none;
        d=google.com; s=arc-20260327;
        b=llvERTbVAl7OZeHCPYFH2Xv2ioi6SvQUQDErJnNGAWuu1JmaKamydxXBJYhFaEVxzK
         N3u46nl2BWK7+vLih7oP9nvq0RHPjVuJndzcigQ2OD8m0WIE/jijPqb9UAzuL3lsiEOI
         6dtVf3IBMFhMLJryZ2MFWoj1wZwJdXLmpV9DcG0Nm6gskL3GnP9C29UaE8n6A8YYIt47
         mhXtNThkIG5UePYndtLcja+N/SxkCJdVUttv5KhUJJJ2wmRB2DWAoSQTOxcR+ACHqMvW
         blM2Lqz1M3hB481gQ7GeHBURH2tV7MQvTP3uPBjv+XhyIA4Im5cteGoBg+jcEgBu1/rJ
         YiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5rBX2/r5Oc8pD3Msk2TcE9A0RNIhE2Nvsx1mMLMnh+I=;
        fh=ygKx8dzBH3WWfd6okczTxrGXpVAf8U0evJ+Ay5jrN50=;
        b=Hm91b+Zk10luUCAS8WE//xbjB1yldkQvN8kda3R8bNVTSAjJ3X1mlhdo5foM9SuK0A
         wRoVULod8I2XW3G+S0fO9CNu8ZEP45YbGHlKlVou+qmxOcj0YTqngyPVfR3hYlfG57Wu
         5FhqwADJza5aKXskwjREy/TBDgBH20ciiPOLDJXkP3/ZQqayN2qAQRSReearfoAZRB4Z
         cvBSpbsUzd/EwgzAyRYAmvDMh8gHob3Qu8W7ugU7H8HkHBYc9vyLv+Y/ZJRH9Z2tXxAz
         B8x6e7St2ZEqkM3s7tgUMhdAiUjLuAXhcAhs5IGjPZG7mC1v7b8tzAhMIV1Z9PyB4Vin
         6r8w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455859; x=1790060659; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5rBX2/r5Oc8pD3Msk2TcE9A0RNIhE2Nvsx1mMLMnh+I=;
        b=bINwWn5rJL585VDKg/aPBf4FOTJH3r9TMEehBCJ9b7zP1J5p9/Xua7cIZtqysVunbR
         bW/10nFH9jM3YvPagT0o7V/U2s8+NYpr1jbS4lewr6SqVJ4AWIJEYF6t7f8Sf7QvcYvK
         LcVMoLh8OobQ+UY1V1WPGAuPY4G5hXF0c4/bKaVa8/aOARCl1WbIeWS9ZJJdYekjeNDT
         piwg2siLA+wHANkhQOHfNgwomN97N2IANT88BujJF6FqeA96BIAiVjkegBLUdpQn3CAv
         hbZIQELt7OaJGDOxvQrH4bzdsQeCn85AO2oUppJfBfbgq8viazCPP2lIl08Apya6zG18
         C/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455859; x=1790060659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rBX2/r5Oc8pD3Msk2TcE9A0RNIhE2Nvsx1mMLMnh+I=;
        b=UbCGNjykUiVp3uB+YQBKW9dmHeeszuTY0yMh9TvX/ap59DtZdlATbOAGu2s8m1uJos
         eszEvgFb3K5zNk6G5+EkvuiG9t1a6pVhApffzmmuPSWc+Hc0g4sN7gVgtfkSPvb5Abi6
         9GsqVL0KS6ig11UF9+63ZWRJRUT4l2qXPWqHbKncMoIMUyEPLLVfSv+v8OmRmuhNF38/
         2GKGEHhc1rqsD5fm7mxc3tfRZ+AXMHveRlV0B/szBeS3xpjh9JyHaAk8lQpXhMI9b8JV
         mzAZ6UMaPPagF0oP+9XL4cpJjry3b1Y+LrKXaC/w+C7ajhnpqPptsTToYK2BNIIdMfB2
         nhzw==
X-Forwarded-Encrypted: i=1; AKwUvBzAQe/XQsgaJSjh5a2w3Nz8WdaG/PyhNGhUtbRcn4MNafSH2XoeSlshnocMuIyugA/eQGZFLA==@lists.linux.dev
X-Gm-Message-State: AFuF++lSapKvDIruUhcGHIGl4XrA4RKVbbfmoc6K0fUA7IvvGKfZnyIS
	sg1CrKY3ScFscol/WkFRkZLtlhNTt49xAqHnM67mXb95yac0oGiyFqZ4ANnRcmuvo5yA8s75Naj
	z26KtdAhft9c4VIlg2X0G/N01Jz+KKzg=
X-Gm-Gg: AYBFou0XYfctkBBpFmSxA+XMjdDgc8P7fbwbpB+F2I+WDmNszyRR3OUI9KN7Wsox2V+
	bH7GkuMpyTUfArRl9zA9XdCAUt10T/V3HSRWdcleVKly/yixWfvcajlLg9h/lH9a4qKWCcEQhFt
	J5r9LxjZI46RJ2lJyPTqERNFiFBjNfUMTqE3vLYBTpdJGDrU3JRJs2UbZwmA3yhP4inFBi9j0pw
	ORbsqwGqRSKJCI9eWKEUyKklZ6x9UG6Bh4dLd7sj98awAvUf6mB0NJoFhtA9F8oNRUqGtfuU9vP
	pyYnm73ptEn+XkQaVEn3fR0U+MGHrwO+noyz323LKYt9kO1qL4248w9WaitB7uxp4yHRRZZ2bM/
	+xScQNR1TAvX31Q==
X-Received: by 2002:a05:600c:6218:b0:49e:7423:687c with SMTP id
 5b1f17b1804b1-49e7a65cb0bmr63673125e9.1.1789455858317; Tue, 15 Sep 2026
 00:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915060937.3423-1-kmehltretter@gmail.com> <20260915060937.3423-3-kmehltretter@gmail.com>
In-Reply-To: <20260915060937.3423-3-kmehltretter@gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 15 Sep 2026 15:04:06 +0800
X-Gm-Features: AcwNN1Us-54OWzGUJ1Z9_Z4eN7azOm4Uvr77tQtD9tUxI7JjaSi59KP2yTRjYgg
Message-ID: <CAN_Opa9rS45S_MHbmf63KC0LY9AGAdAC5r=vv_qcYMVAenWosQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/damon/tests/core-kunit: test PSI goal rounds under
 the temporal tuner
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lian Wang <lianux.mm@gmail.com>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:09=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> Exercise a PSI quota goal under the temporal tuner on its first
> round, its next measured round, and after a goal commit. Use
> ULONG_MAX as the target so the goal is not reached during the test.
> Then check that a measured round which does reach the target sets
> the quota to zero, and that the consist tuner keeps its quota over
> an unmeasured round.
>
> Without the previous patch, the first and the post-commit checks see
> a zero quota.
>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  mm/damon/tests/core-kunit.h | 69 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index c01e6a75cadc..2b9b24ce7dad 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -889,6 +889,74 @@ static void damos_test_commit_quota_goal(struct kuni=
t *test)
>                         });
>  }
>
> +/*
> + * Unmeasured PSI goals must not disable the temporal quota.
> + * Keep sz * 10000 within a 32-bit unsigned long.
> + */
> +static void damos_test_set_effective_quota_temporal_psi(struct kunit *te=
st)
> +{
> +       struct damon_ctx *c =3D damon_new_ctx();
> +       struct damos_access_pattern pattern =3D {};
> +       struct damos_quota quota =3D {
> +               .sz =3D SZ_64K,
> +               .goal_tuner =3D DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
> +       };
> +       struct damos_watermarks wmarks =3D {};
> +       struct damos_quota_goal src =3D {
> +               .metric =3D DAMOS_QUOTA_SOME_MEM_PSI_US,
> +               .target_value =3D ULONG_MAX,
> +       };
> +       struct damos_quota_goal *goal;
> +       struct damos *s;
> +
> +       if (!c)
> +               kunit_skip(test, "ctx alloc fail");
> +       s =3D damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
> +                       NUMA_NO_NODE);
> +       if (!s) {
> +               damon_destroy_ctx(c);
> +               kunit_skip(test, "scheme alloc fail");
> +       }
> +       damon_add_scheme(c, s);
> +       goal =3D damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US, ULONG_=
MAX);
> +       if (!goal) {
> +               damon_destroy_ctx(c);
> +               kunit_skip(test, "goal alloc fail");
> +       }
> +       damos_add_quota_goal(&s->quota, goal);
> +
> +       /* fresh goal, first tuning round */
> +       damos_set_effective_quota(c, s);
> +       KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);
> +
> +       /* second round: last_psi_total is initialised now */

Could we also check goal->last_psi_total here?

The first tuning round should consume the U64_MAX sentinel
and establish the measured state.

Testing this explicitly would lock in that state transition.

Thanks,
Kunwu


> +       damos_set_effective_quota(c, s);
> +       KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);
> +
> +       /* commit a PSI goal onto the initialised PSI goal */
> +       damos_commit_quota_goal(goal, &src);
> +       damos_set_effective_quota(c, s);
> +       KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_64K);
> +
> +       /* a measured round that reaches the target disables the quota */
> +       goal->target_value =3D 10;
> +       goal->last_psi_total =3D damos_get_some_mem_psi_total() - 10;
> +       /* U64_MAX marks an unmeasured goal, keep the sample away from it=
 */
> +       if (goal->last_psi_total =3D=3D U64_MAX)
> +               goal->last_psi_total--;
> +       damos_set_effective_quota(c, s);
> +       KUNIT_EXPECT_EQ(test, s->quota.esz, 0ul);
> +
> +       /* the consist tuner keeps its quota over an unmeasured round */
> +       s->quota.goal_tuner =3D DAMOS_QUOTA_GOAL_TUNER_CONSIST;
> +       s->quota.esz_bp =3D SZ_32K * 10000;
> +       damos_commit_quota_goal(goal, &src);
> +       damos_set_effective_quota(c, s);
> +       KUNIT_EXPECT_EQ(test, s->quota.esz, (unsigned long)SZ_32K);
> +
> +       damon_destroy_ctx(c);
> +}
> +
>  static void damos_test_commit_quota_goals_for(struct kunit *test,
>                 struct damos_quota_goal *dst_goals, int nr_dst_goals,
>                 struct damos_quota_goal *src_goals, int nr_src_goals)
> @@ -1887,6 +1955,7 @@ static struct kunit_case damon_test_cases[] =3D {
>         KUNIT_CASE(damos_test_new_filter),
>         KUNIT_CASE(damos_test_commit_quota_goal),
>         KUNIT_CASE(damos_test_commit_quota_goals),
> +       KUNIT_CASE(damos_test_set_effective_quota_temporal_psi),
>         KUNIT_CASE(damos_test_commit_quota),
>         KUNIT_CASE(damos_test_commit_dests),
>         KUNIT_CASE(damos_test_commit_filter),
> --
> 2.53.0
>
