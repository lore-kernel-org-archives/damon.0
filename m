Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB0B3176E8
	for <damon@lists.linux.dev>; Fri, 15 Aug 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280300; cv=none; b=LNHA/DvJ7gufWsXXfTpCeEg7m/qgmjxYEUPo9YLINOZl5SQLh/SreFPDwv/PneZHKPb8L1H1N2LdqB7sJ4RkRepRsyIennabTJziUD/h7nN8dEd3i+dpBJyI5r6Z/gDsJNTSs9uce4Bhw6G5bXzhJji5dCFAoTLQDduf/S+4Rpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280300; c=relaxed/simple;
	bh=Mw+kCsH1LEqRX0xIi485fYTMBbhV7nCPhw+PqbP2J94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uNO58Kj4EbcrC8QGl0E5Yfbv6BA+wfusPG3K6As93zmCm24oCs6rMVPRdZywWUEnLSY35UnrPBw2RItAkBf32C+DQm4y56rDNzf2Yh0a57l6hH47eTiAQuXNYX3MfGjqAv14gNEXv2l1DiBRCs9vDGIrmAU3vMAe2/PScgMvDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8jYM6LP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8jYM6LP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EC0C4CEEB;
	Fri, 15 Aug 2025 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755280300;
	bh=Mw+kCsH1LEqRX0xIi485fYTMBbhV7nCPhw+PqbP2J94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8jYM6LPxJ1nfo3vFlVGUXAJSvvI+tVL+q0+tmB3pIRf8QTc/ctpFqITt6WudDHkw
	 tRmqDg/FLV8FwkfFFgbMnXG0S1Xxt7KqwuqLZPRNhZIE2o24PSv5QlLhOaaj0Kn5QC
	 ROE8LCLuHSiTmsOYnrgxHJBeAkydgjq530XdDqJmCA/CCajp/V0Z8XF2ZTdSezb+MY
	 FBa+wv5deV09Y651KBhu0+eYliHc0TMvsXuqYlaevUpur9aanbCpP6FVPo2hyOKXYw
	 Jgnfk/x3X1bwsUbH74+2OgMEZdx+UreLYm0syTbSx+VIWbGj6OGdpQ2mLw8HoBGEll
	 xe8nG2F27MABA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stablee@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_commit_filter not changing allow
Date: Fri, 15 Aug 2025 10:51:35 -0700
Message-Id: <20250815175136.87287-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250815172545.16704-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 10:25:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 15 Aug 2025 18:40:59 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
> 
> > Current damos_commit_filter() not persist allow value of filter. As a
> > result, changing allow value of filter and commit doesn't change
> > allow value.
> > 
> > Add the missing allow value update, so commit filter now persist changing
> > allow value well.
> 
> Thank you for finding and fixing this!
> 
> > 
> > Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
> 
> At the time of the commit, damos_filter->allow didn't exist.  I think below is
> more correct.
> 
> Fixes: fe6d7fdd6249 ("mm/damon/core: add damos_filter->allow field")
> 
> Also,
> 
> Cc: stablee@vger.kernel.org # 6.14.x

Sorry, s/stablee/stable/ please.


Thanks,
SJ

[...]
