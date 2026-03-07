Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B528B7EA;
	Sat,  7 Mar 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851240; cv=none; b=j3cz4n+e2CHFD5xXvea0iLhXoanSQQeTs6fPr8R3fY9iByZW3LSIAhAvIdqy9FHXfVZSZV8MIEg4mF8f1NIgKcxbWRIjGDbnqfSMCzjVeb0ZEzoi5sS8TO8H24zyKuarQBbSc8PHunM4FTJxcnP7q6y7n3HuL5vYDyOF3imFRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851240; c=relaxed/simple;
	bh=VqI2kIRTJXcSdhafyI+w1IVbVYZZCzcxRnZsSstOUaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncFhBGt9nr5xoAJcbvJYf1n1PlDBSpmi2GBLbZNj+2zwebG0pD18ScMpwrrVu8DmeMzLT+QOvK8JolUx7ZWVt2mVfZ0fKSRwB1Z8reuBcsW6gh4pkH/5bS6lI68Zs15CgrMmdIHZiRe1MrcThmY+tqISo32gL7O8FCAVISmWgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ferhLrld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ferhLrld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70760C4CEF7;
	Sat,  7 Mar 2026 02:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772851239;
	bh=VqI2kIRTJXcSdhafyI+w1IVbVYZZCzcxRnZsSstOUaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ferhLrld/gwQTRzDxSeIPiI1QMqpGlVrfPKpRtvO9Fz6qOa+gECS+KwgNbIeZZnbV
	 AO/5+XWo+JNgl5udjLqov9bg4iLOfFDnnbrGKIi0IUUaSnm9pvJWLqKQCn4n4Hn+6j
	 /+qh4e34uEzetoXDwT+clGAoobCzDga4Iynfj+GfREluKfs0Gm4tcllqmgYGuXSnOD
	 6SVAyCv7X6J42O0zgXpMm74LSEDRFa6ZuYkW3z2eeY4rvoIPGZi4hDxDEu90LVBZE9
	 6EKtFVjoUgRZdWA5DWu25knB+E54cs+ECjHckKgI3VLx3+8+3PQQSo2bddFh7523rL
	 K7pQzSoBtOzSw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 01/10] mm/damon/core: introduce damos_quota_goal_tuner
Date: Fri,  6 Mar 2026 18:40:31 -0800
Message-ID: <20260307024032.86777-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  3 Mar 2026 20:41:10 -0800 SeongJae Park <sj@kernel.org> wrote:

> Currently DAMOS quota goal feature utilizes a single feedback loop based
> algorithm for automatic tuning of the effective quota.  It is useful in
> dynamic environments that operate systems with only kernels in the long
> term.  But, no one fits all.  It is not very easy to control in
> environments having more controlled characteristics and user-space
> control towers.  We actually got multiple reports [1,2] of use cases
> that the algorithm is not optimal.
> 
> Introduce a new field of 'struct damos_quotas', namely 'goal_tuner'.  It
> specifies what tuning algorithm the given scheme should use, and allows
> DAMON API callers to set it as they want.  Nonetheless, this commit
> introduces no new tuning algorithm but only the interface.  This commit
> hence makes no behavioral change.  A new algorithm will be added by the
> following commit.
> 
> [1] https://lore.kernel.org/CALa+Y17__d=ZsM1yX+MXx0ozVdsXnFqF4p0g+kATEitrWyZFfg@mail.gmail.com
> [2] https://lore.kernel.org/20260204022537.814-1-yunjeong.mun@sk.com
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
[...]
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
[...]
>  /**
>   * struct damos_quota - Controls the aggressiveness of the given scheme.
>   * @reset_interval:	Charge reset interval in milliseconds.
> @@ -260,6 +268,7 @@ struct damos_quota {
>  	unsigned long ms;
>  	unsigned long sz;
>  	struct list_head goals;
> +	enum damos_quota_goal_tuner goal_tuner;

And the above change is not updating the kernel-doc comment of this struct.
I'll add that in the next spin.


Thanks,
SJ

[...]
