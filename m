Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43076259498;
	Sat, 20 Jun 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975385; cv=none; b=ZafPe6Ff/EX7gMAZQIL8bJCawoJycacd34DY1qiVL82riIQ4AlpMcznaYnqekfMzqoC08io08/DE5ntrhIwRjXkfaysp7wvjz+YFt8Lr1yutjljMrWKOETMyY194Ugz/0K+yEkbt6Js7PRpB7HsABiUiUiZKIaIH/VKdoPDbuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975385; c=relaxed/simple;
	bh=4+wMkiZi72DzPSFzv4RvAWSZa8Bl1TVYzcvvGmFfUds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tig/Gka+ti5/IDqB0UAA9JRRCRXG57V293tzxctYbBqrBPxlhwgPcpJa2ZeWzymKTDLxwOn4QGaAGTYq9M8V9LM0IKHztIiwDOhrzyaaBWaK5DvlbH5O38w1Yh9QfA+6cWoph3LOnIJN1V0h4ANHGPMT2J5bnNd6kk+mC3z44Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTVpcr6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTVpcr6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0551F000E9;
	Sat, 20 Jun 2026 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975383;
	bh=eJQEX0ob4V6ASpCMyc/x/VPDvEIn5+uylrmiAJ0yFzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTVpcr6JDHLYZuXCYK58NKBB/UYphUSslSKPRpNb+dtuSksTp4gR2YKUXBSP9yUKI
	 juyvP6/i7S81dXuDA7ybJAH6/CVStcL69dw+7NE7VX2DKgTOPSvtZfD1idvq6kpUpO
	 kzrRf/d3Vm9jaj4WuET6G56HZjgNkMGX3cKepPBrc+2GLcjOfQefVeJvBsumltD8i/
	 IW5gPNoBXBybrGjEO/27dApXuxrRwfRjAaexKCvIvK+EoDSSNowOTKsFGvuCEHwwkt
	 QTNnZLXkWJt3SKWSvbNyi9MtsIu1aU2G8jw8rXgcHkQntM18x3s6T+QicAtvl8GTq7
	 C/OVx5HVJb3ag==
From: SeongJae Park <sj@kernel.org>
To: yahia <yahia.a.abdrabou@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon/reclaim: fix potential memory leak
Date: Sat, 20 Jun 2026 10:09:34 -0700
Message-ID: <20260620170935.89236-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620165055.7247-1-yahia.a.abdrabou@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 19:50:55 +0300 yahia <yahia.a.abdrabou@gmail.com> wrote:

> Hi SJ,
> 
> Regarding you question in v1, This patch
> addresses a potential memory leak in the
> out path, ctx is never destroyed during exit
> thus creating a potential memory leak.

It is kept in the memory by the design.  It will be destroyed when the user
enables DAMON_RECLAIM later.  So, unfortunately I don't think this patch is
needed.  Please correct me if I'm wrong.

Also, I'd recommend you to thoroughly read and follow the patch submission
guide [1], if you didn't have a chance to read it yet.

[1] https://docs.kernel.org/process/submitting-patches.html


Thanks,
SJ

[...]
