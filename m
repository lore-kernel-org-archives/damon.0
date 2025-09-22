Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19EE309EF4
	for <damon@lists.linux.dev>; Mon, 22 Sep 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546096; cv=none; b=ECZbKMErq9QwXxUdEqdRkrpD4wUk4YOdgccIaqqosrWl1y/Kgp3dIROtd9yZPdSipXZGUymNV1P4k0GWNFkIf66urSiIIV1LaOMFLubJantvR04W0OYKsY5ooBJpW29WZ0Ox56/cT4EYoT3mNdjteNitFB3RCbndYPuqM6nd8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546096; c=relaxed/simple;
	bh=2CAnXG1qkWNikidwFhEXx27Lsfxn0xi7bL5FS8cZuG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUU9hnkfQMvdjOWkRsZ11kKIfUFzxp2cK43z6RD1KZzpQqSBgBUWBV2kXzYOtFsBAw9lSsymvW5DIvAh6gHlFNZesrrhYv4M7d+0OEbAZTjJFFVDA5bqi3GR/8NlBVFS9KhrGKTM3Io0840mCC5Auvo9M3tMApYpHtwN/rp8Suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP88G1FG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP88G1FG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0335CC4CEF7;
	Mon, 22 Sep 2025 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546095;
	bh=2CAnXG1qkWNikidwFhEXx27Lsfxn0xi7bL5FS8cZuG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rP88G1FGh9eIvjgLwQ9ozeQhogSfb7c0c3rIE0FEHjSH8ac7T6zO+XW9tMpfX0URe
	 EowI/udzGp+XOMFj+KRuFwL/tzpiXcQCOiU7qh/8Oa9luR+2m9zmB0ZEO+H6XoK8YM
	 EVGgC7LXAYWA7qLPWkUpf4v93WKncWRiWwmGWwq5kueVU9dSf3/tJMPF46SkpyrIyP
	 Z6yljbBKz+CXWeKq4Qd47/HPK0UQGXpOlAm3NpFzNl5fvgwamDpKN1l1UMaM4n33rm
	 xSSllXWC1RKwpQzRPiYlRZa20ofyoggMllBUm64lP6nW0IOANmIGsISbCzuZYSY2cn
	 QWJaRyjzi2D2g==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [RFC PATCH 0/2] DAMON: add priority-based scheme application control
Date: Mon, 22 Sep 2025 06:01:32 -0700
Message-Id: <20250922130132.59955-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922101022.362822-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Enze,

On Mon, 22 Sep 2025 18:10:20 +0800 Enze Li <lienze@kylinos.cn> wrote:

> This patchset introduces a priority mechanism for DAMON's scheme
> application, allowing users to specify the relative importance of
> monitored processes.  The changes ensure that higher-priority targets
> receive more frequent memory management operations while maintaining
> fairness across all monitored processes.

Thank you for this patchset.

There are features for monitoring target-based DAMOS filtering
(DAMOS_FILTER_TYPE_TARGET) and per-scheme applying time interval
(apply_interval_us).  Couldn't those be used for your purpose?

> 
> The first patch modifies kdamond_apply_schemes to implement
> priority-based scheduling, where targets are processed in proportion to
> their assigned priority values.  For example, a target with priority 50
> will be serviced 50 times for every 30 times a target with priority 30
> is processed.
> 
> The second patch adds a sysfs interface (priority under each target's
> directory) to dynamically configure these priorities at runtime. This
> enables fine-grained control over DAMON's behavior, making it more
> adaptable to performance-sensitive workloads.
> 
> Together, these changes provide better flexibility for users who need
> differentiated memory management policies across different processes
> while maintaining backward compatibility with existing setups.
> 
> You may want to verify this feature using the following testing
> procedure:
> 
>  # git clone -b v2 https://github.com/lienze/damo.git
>  # cd damo
>  # ./damo start --target_pid $(pidof <target1>) --priority 50 \
>  --target_pid $(pidof <target2>) --priority 30 --damos_action \
>  pageout --damos_age 5s 5s

So I'm wondering a command like below could be used instead.

$ sudo ./damo args damon \
	--target_pid 123 \
		--damos_action pageout --damos_age 5s 5s \
		--damos_filter allow target 0 --damos_apply_interval 3s \
	--target_pid 456 \
		--damos_action pageout --damos_age 5s 5s \
		--damos_filter allow target 1 --damos_apply_interval 5s \
	--damos_nr_filters 1 1


Thanks,
SJ

[...]
