Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607D37473A
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913675; cv=none; b=h3jgujefiJ9ukXuL0caCEr4rfse0PygbREF5G9L6ZCh/vuG9PDOwhG9hL4E8F+q961UZ8bxgWNCwwL6lldtFJwkHaDRoIBQ7+PKg7yQsA6Td5ZMYLmYfJNr5vA+W6qk/m27wPj/BkLm4uxiOCg5w0l8GdD4wHTcM7qNLOxTVNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913675; c=relaxed/simple;
	bh=rOYFqfKdOMzs6VYlE42XKH2BfXEceu73iEUs4F1Vap0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQM2iCHOP/zDFXJgdGSqC1h64omdQF1H31DWRRZ3xUnAbYEQ6GVJLi+H6O1veALOhkficKn7q6vnwdr3oke3Qvwk/OIpf1WOOCELKBegbcr8yTJy9G7quDOUyU4ZZUrIVX7pGb4+NTBd1xjJOtZhJD41AOy5BfxnyZEu4QymHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0YAvTKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0YAvTKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369FEC4CEF7;
	Mon, 30 Mar 2026 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774913675;
	bh=rOYFqfKdOMzs6VYlE42XKH2BfXEceu73iEUs4F1Vap0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0YAvTKn5WBKHz+KwKESwmbAcutQnWmbccH7rgz8A7WonyeJY8YyPbzAxOillO9MM
	 GtSxTB0Hhz7wBI4JlJeRRtfZC2+s7iYAOVHDjEnQ4/uGBgsSStN/j8bWOp21nuVbcB
	 kI9s8v2SACens+zjjLcpbmyceHmN4P7x7mhYUTFEew7Q3lKZiufCX+DB4cD0gz4Qxq
	 3I4WTnasME00xo6bp1jckmsp1JdqwdrjU2292mVvkan5V/rdHAGfqF0QLr/dj3Atfy
	 bh7+MUyAZufkS068bcOXTmbe2PzBIP55XIPWttUDUAkmOYTgYB1iE3DXVZNxpqcOy9
	 9m32l7Ru/oEPA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Mon, 30 Mar 2026 16:34:33 -0700
Message-ID: <20260330233433.4208-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330071736.17143-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Mar 2026 15:17:36 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Mon, 30 Mar 2026 14:08:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > [...]
> >
> >     min_region_sz = max(PAGE_SIZE / input_addr_unit, 1);
> >     if (!is_power_of_2(min_region_sz))
> >         return -EINVAL;
> 
> Apologies, I just realized I made a silly typo in the code above.

No worry.

> 
> I used PAGE_SIZE where I should have used DAMON_MIN_REGION_SZ. While
> they happen to share the same value in many cases, DAMON_MIN_REGION_SZ
> is the correct semantic constant for this context.
> 
> The code should be:
>     min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);

Yes, I agree.

> 
> Sorry for the confusion.

Again, no worry!


Thanks,
SJ

[...]
