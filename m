Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB7230D3D;
	Mon, 10 Mar 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625603; cv=none; b=kC7p842ak9eGfvYHHPmlka1dtTmdw7AqF3ooTbg/Oj4T2NPgTsHYu5bp82z57J7rQsX56i4FldzVnDe7YDtMDOa6zOrv/+ncoRcL5QNrv4ahfY2SxI1Z9qv52r1xac8aYEPUjeZCZjduwg1GnbBZS2wmyHDcj5nekqALXNnkBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625603; c=relaxed/simple;
	bh=HBDhINxnPgvOAIWPpnpaFKFbX8KU13d1faK9QcRfp1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KofvllsGm2j3EW2lTciHVVxtDr2/MjypCiawlgxq+v3h5oypEvhG3uLZv2j05765kbvz9G08a3YfI5KfwULHvBBGxQytx26DbT5dqhn2qLIsw7blQZ4zhYK8Lv/YvouRmD225uI4j+lhoq3Bzy1a4/A77y2OriWkx4ZJETo6tHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIVdvhd6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIVdvhd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73539C4CEE5;
	Mon, 10 Mar 2025 16:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625602;
	bh=HBDhINxnPgvOAIWPpnpaFKFbX8KU13d1faK9QcRfp1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIVdvhd678HNL0faoELOfUPwicMwcwH+Arwd45toviruHfiau6Zg7APdPI7ZuA0RO
	 69VlLuS8TqzutYj4w7dpuNsI2FXMZjWJbDHYEzQbC2136tOx1nInRQERf0ahGauFD4
	 bjbtdEHDouBxw+hTPIidf1Ukb+mmoWZ+GyiS8q8GmIdP4FS5g98cHOYeb2fZH7jMgl
	 EX+KdhWDv7XaCC1ZVdjwdjW/PdARLR1zQpCYGmjkIw3hFqCpU5ZZBoAxc7E2lHgcog
	 3RJN3LswI3IuXGEPZgHkCDrhYyRyRDqcPwXZwgclfx9RN9GdPGhJuc3APwoyhO5SbL
	 TcAFDWlANyc4g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: avoid Wformat-security warning
Date: Mon, 10 Mar 2025 09:53:20 -0700
Message-Id: <20250310165320.652617-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310161758.606151-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 09:17:58 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 10 Mar 2025 14:51:37 +0100 Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > This warning is for potentially user-defined format strings:
> > 
> > mm/damon/sysfs-schemes.c:1664:4: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> >  1664 |                         name);
> > 
> > Change this to use "%s" as the format and the name as the argument.
> 
> Thank you for this patch!

I also found there is another similar issue and sent another patch[1] for that.
Thank you again for sharing the issue.

[1] https://lore.kernel.org/20250310165009.652491-1-sj@kernel.org


Thanks,
SJ

[...]
