Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D8352077;
	Tue, 26 Aug 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218984; cv=none; b=dY9GtLIVlM+Ndn+Gg8d29FwmGyOWICZu6oHTuAT8gtRGGa8F8qfi7Ri4lOKROSTqAeUhN9u7vB+L9tnmeQmhO5sWT2pytRmINBqa6VnyWFPTcHFXkq20g3Hq5IfEc/f4YAP6VKMH1/yickEWKRVl+gKd27RvdbVa7pVxXEjJKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218984; c=relaxed/simple;
	bh=cm3c4GhML4E6RLlw/VFFFI6QieoD1VhZ+qpko2GXjyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCwsHpdSWmW7H2yH5BNshr8KSi9CjoQBwSTSxb5HPNto31+IoM5TAxROG8Ry3rv/2f9eCDffW4wfo5hymyF2uOdNeev9pEyORHybACvwExa0cLG4eA+HX6oryLDVXYgqyKUsdfrHh1cG1J+77uKwvz2gYhMHAEOUhSK5tOAMNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayhHbx5X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayhHbx5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C286FC4CEF1;
	Tue, 26 Aug 2025 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756218983;
	bh=cm3c4GhML4E6RLlw/VFFFI6QieoD1VhZ+qpko2GXjyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayhHbx5XdlTVbBQ83nz6wO1nSS9vqlStNZOOG4jTgJgJDS3VtRKhdkP7ZLrRpWPaT
	 JB5ee9SGB2pMIarQFFwO7fifRY1djZycI6TrkVkSDCwqxbkH0Q7NuBBLYnWdnWCT0a
	 fW8fMzjMky/bJjZLQM9Ov/3pXgAlzNv6Q/9NmqTKgdY0dk+8RFJx6s1KVfEXqATzd+
	 QJgN6H7qIlZmqy2y5YspLoUP6ZQiJFR9DMjyA7hlZfUS83FUbZWCsYKIfY767lQfzT
	 RmjLh2JzIjKVAfaGeZbzRaW8s7y5iagKdA7GkXnZm7Kq6rpWS2VOBUTwIeAIlmHtUN
	 q9O3WJBQauSgA==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH 0/2] mm/damon: void divide-by-zero in DAMON module's parameters application
Date: Tue, 26 Aug 2025 07:36:22 -0700
Message-Id: <20250826143622.54331-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250826033653.1208227-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 11:36:51 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> DAMON's RECLAIM or LRU_SORT modules perform no validation on
> user-configured parameters during application, which may lead
> to division-by-zero errors.
> 
> Avoid the divide-by-zero by adding validation checks when DAMON
> modules attempt to apply the parameters.

Thank you for finding and fixing these problems, Quanmin!  All looks good,
though I think it would be better to add 'Cc: stable@' tags to each patch.


Thanks,
SJ

[...]
