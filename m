Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BD18EFE0;
	Wed,  9 Oct 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475313; cv=none; b=nWE5mwBzOo4JZVKZ1TEGHez1aX0zY2KVZeoAopDuJDajsSnIqeI8hq9fmhXEa8mlTIjbfAAkWaR4XBHjm/3g1xgm8Zym6YmFoZ5oVDdT/Qv5CHTYB7TVHwpqGwZZ6yC6Cy4tIWFSIgVv/bPiFPHS7QxFXd9No5Bv8BHJVCt40dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475313; c=relaxed/simple;
	bh=zeg7d9mAEdtrJLKo6NlpC32nCow+JsGBo1Wskv/IHqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx2wt7Y7KotlpcDhGWibWR+AMaQnVTHEdCXM4oWcfOqLa925dXG8qPLplphtX/3jDEcSDB83Vrt74H94UvB4ASCJml3+kfK6bx5fzK1HZEkk8FCAaa94Z0fUzAoYOHh+Ih+nuuwcu/QWCS+WzxqU7lUFRKgu4kWL/BHJGm+7gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKVYtJhO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKVYtJhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17649C4CEC5;
	Wed,  9 Oct 2024 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728475312;
	bh=zeg7d9mAEdtrJLKo6NlpC32nCow+JsGBo1Wskv/IHqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKVYtJhOY26FBiMjwtV8B8XfCgY10sPmmH0d3ezBJeWPQVZTNl88YO6kVnv/9KtQo
	 UhQsfv0KShlil1R0GvI4K/Mto1ogHg94ntFrOm+ucSogRk/56pcjV0gY8uJZdf3ELB
	 LAZfMmkH/zU2IYfn69lCQjDeUCed4mEVvcZ8iyQ2EuA7FfsJGBK+E+IREBGkqXwD0b
	 tmVcm30LNbJiR3g2lNHybF0UvtPn5ybLmyQlJvDYoLJIf7J9L41ls5J7TyOmu7K1RC
	 v3JgO0y/amCPIljlKhUQXb0fqIY8alqIBG0v5yv86PMyAFlqc76axZwwKQ5a2ibFuY
	 MfwRFsD5y/qxA==
Date: Wed, 9 Oct 2024 14:01:49 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 08/15] mm/damon/core: Use generic upper bound
 recommondation for usleep_range()
Message-ID: <ZwZwrXpRlMW_22kk@localhost.localdomain>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-8-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-8-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:34AM +0200, Anna-Maria Behnsen a écrit :
> The upper bound for usleep_range_idle() was taken from the outdated
> documentation. As a recommondation for the upper bound of usleep_range()
> depends on HZ configuration it is not possible to hard code it.
> 
> Use the define "USLEEP_RANGE_UPPER_BOUND" instead.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: damon@lists.linux.dev
> Cc: linux-mm@kvack.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
