Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767E3112BC;
	Sat, 21 Mar 2026 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123977; cv=none; b=n0f0ldNDMYYHkJRNdA2Q0RLhTJGlPlJZIIbnLLFkoOJ0kKsQoC8Im/10RUSTsxkilwvuRZKvKBwfdyTQV0oppFx2KH3Coczg02PAiyDNAl9uBBAAv10Am7oCn8/DTgbj1rJpY9PSzZ9rZKworuy+7Z0NugiOMA/Fz2JZYiBUTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123977; c=relaxed/simple;
	bh=NVQdlnexlbZWj9Y/C0skFJH7Ccw+Ra+VVoACTnCMddQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZrcIBadTpXu+WOrT7yNB4A33mfPa3qTkhWkMFaER49EhaIv7DfPyFh4gQaakFaJIkyK17xDW7ZS998jB+IBsaJ/lMbK2+7/lI+k2WtJfrUAxHACO/0xlA46idaw/T7+req/c6T1gLpiiBxFupVcg8G94Otq4ombwTqe63ey3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knZjaQ3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knZjaQ3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBEDC2BC87;
	Sat, 21 Mar 2026 20:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123977;
	bh=NVQdlnexlbZWj9Y/C0skFJH7Ccw+Ra+VVoACTnCMddQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knZjaQ3zOODa5K1OITF/rxTrNYzbiCsy8bdjTRLa6mdR/l6IFvAVqmFEmMAWq0vGL
	 bHhambtDAnhviLc69ZuvBvfkN2uAVxG1r1q+4/lo0u1TfVXdfGdoYOIK/eDrnVmbnD
	 ig8jZe/mc9MU7fBthDQcvS+Ap1sl55IMADcONTLs81T9dKO1pR+/xB+Gvqt5++woYx
	 lYOxhdEwGVkClJBUdMB9OQuBwMMoN9BMq+ANv5rBVZ3+KtyFAqYZNivPi8lWkq84oB
	 U2TtpE4rNyMZp4h0lCZBG78chgevEuy7m4Q8QhTI8zQAaq/Ct5SBWWOJNIQmWvTSKr
	 RAD3uQ09EIMmw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko) [PATCH 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Sat, 21 Mar 2026 13:12:49 -0700
Message-ID: <20260321201250.95873-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-11-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260321181343.93971-11-sj@kernel.org
# start of sashiko.dev inline review
commit 019bf04e4448bbce4f6d092792a1b959f718f39a
Author: SeongJae Park <sj@kernel.org>

selftets/damon/sysfs.py: pause DAMON before dumping status

This isn't a bug, but there is a typo (selftets) in the subject line.

This commit updates the DAMON sysfs selftest to pause DAMON execution
during state dumping. This prevents potential races caused by internal
DAMON changes, such as the addition or removal of regions, while the
dump is ongoing.

> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -193,18 +193,53 @@ def assert_ctx_committed(ctx, dump):
>      assert_true(dump['pause'] == ctx.pause, 'pause', dump)
>  
>  def assert_ctxs_committed(kdamonds):
> +    ctxs_paused_for_dump = []
> +    # pause for safe state dumping
> +    for kd in kdamonds.kdamonds:
> +        for ctx in kd.contexts:
> +            if ctx.pause is False:
> +                ctx.pause = True
> +                ctxs_paused_for_dump.append(ctx)
> +        if len(ctxs_paused_for_dump) > 0:
> +            err = kd.commit()

Since ctxs_paused_for_dump is initialized outside the outer loop, if the
first kdamond appends a context to this list, won't len(ctxs_paused_for_dump)
> 0 evaluate to true for all subsequent kdamonds?

This seems like it would trigger kd.commit() on every subsequent kdamond
even if none of its contexts were actually modified.

[ ... ]

> +    # resume contexts paused for safe state dumping
> +    for kd in kdamonds.kdamonds:
> +        for ctx in ctxs_paused_for_dump:
> +            ctx.pause = False
> +        if len(ctxs_paused_for_dump) > 0:
> +            err = kd.commit()

Does this inner loop repeatedly modify contexts across all kdamonds on
every outer iteration?

Because ctxs_paused_for_dump is shared across all kdamonds, this appears
to redundantly modify and commit contexts for every kdamond instance.
Could ctxs_paused_for_dump be scoped per-kdamond instead to avoid this?

[ ... ]

> +    # restore for comparison
> +    for ctx in ctxs_paused_for_dump:
> +        ctx.pause = True

Since the context was forced to pause before the status dump, and the
python object is forced to pause right here before the comparison,
doesn't this mean the test only ever asserts that True == True?

It appears this entirely skips verifying whether the originally requested
unpaused state was successfully committed to the kernel before the dump
procedure began. Any kernel bug where the pause parameter is stuck as
True might silently pass this test now.

Should the original state be verified by reading the specific sysfs file
before overriding it?

[ ... ]


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260321181343.93971-11-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260321181343.93971-11-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
