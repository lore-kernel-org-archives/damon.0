Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA01B4156;
	Sun, 22 Mar 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199743; cv=none; b=H0pthvi/168xtuybVqPBdKESB8EKq5LQtN9nBojbG0eaiq3l+imqWIIXk5GO6Q7JRQBvMzc7ZswR6AKPG6h3fipCyW/HY1IfLRCaiXmDGINkITZ11tSrw7gfiCciEW5601T1t2kaVL5x4DQPtqDB5poRm2ShEt0s+7Tt/TFwDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199743; c=relaxed/simple;
	bh=sNsCiQ9Si+6TpKQyQrImtsi34DirRqh8jDGiNngIzjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxbeMBFFe0p9pGbCfdJIjKJoHgZsram3ihL0xbAvzUd3EuKaX2qb1mmwPWnnlsh+oyOKFpO97KMGnWLOHKrA3UHxWjVEB19MhnFGyKoHzYdqHsT6rAudNgPaTeGF+CzNiRDhHK1SRYaPjmkYTTLQlqPGlhrLO1nXjGwLf/54Hoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBIfKVkc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBIfKVkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1641C19424;
	Sun, 22 Mar 2026 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774199742;
	bh=sNsCiQ9Si+6TpKQyQrImtsi34DirRqh8jDGiNngIzjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBIfKVkcjzshlqgH6YEi3+7i8bpiUNzvGkm4k/e1UoS0MViRx7tGYNVoBG+t/qA6N
	 CcKkZ6eQI/x6pnr/L7jD7ngDLybhxGGzTBZ3G88q6+RP47dMmhRMKBy/DprzQSaW18
	 EmbSyVNv5QopXVFvEwO4bLLlTjG3EKdIVRkfzMNjKua9peJx4TR/gyATTmOSogSiw/
	 Hi16uIailVrr38I24AIZ3HPCSEAZwO3RTlJGrfXBsVODqI6laMDzpEcS5AS/l6BBof
	 Y2Ch4i/pFgc+VndAlx41YXtipy7O2i9MykpwnSjRZXhX8c8ZRXpdC5YAR1YOQi4X+n
	 emVCv3N7p3Prw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v4 10/10] selftets/damon/sysfs.py: pause DAMON before dumping status
Date: Sun, 22 Mar 2026 10:15:33 -0700
Message-ID: <20260322171534.83470-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-11-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260322155728.81434-11-sj@kernel.org
# start of sashiko.dev inline review
commit 67adf8e7b8416252faf583e176f0e8424fd4fb95
Author: SeongJae Park <sj@kernel.org>

selftets/damon/sysfs.py: pause DAMON before dumping status

The sysfs.py test commits DAMON parameters, dumps the internal DAMON
state, and verifies the parameters. This commit pauses DAMON execution
during the state dumping to avoid races that can result in false test
results.

> selftets/damon/sysfs.py: pause DAMON before dumping status

This isn't a bug, but there's a typo (selftets) in the subject line.

> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
[ ... ]
> @@ -193,18 +193,55 @@ def assert_ctx_committed(ctx, dump):
>  def assert_ctxs_committed(kdamonds):
> +    ctxs_paused_for_dump = []
> +    kdamonds_paused_for_dump = []
> +    # pause for safe state dumping
> +    for kd in kdamonds.kdamonds:
[ ... ]
> +    # resume contexts paused for safe state dumping
> +    for ctx in ctxs_paused_for_dump:
> +        ctx.pause = False
> +    if kd in kdamonds_paused_for_dump:
> +        err = kd.commit()

Is this if statement intended to be a for loop?

Since kd is just retaining the value from the last iteration of the earlier
loop, using an if statement here means that if there are multiple kdamonds,
only the last one might have its state committed. 

Could this leave other kdamonds un-resumed in the kernel?

> +        if err is not None:
> +            print('resume fail (%s)' % err)
> +            kdamonds.stop()
> +            exit(1)
[ ... ]


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260322155728.81434-11-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260322155728.81434-11-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
