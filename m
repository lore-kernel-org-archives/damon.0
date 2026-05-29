Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFF3E170F;
	Fri, 29 May 2026 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066381; cv=none; b=pxQZthsN0rSFV1RXIFQI276o08iFpzpvTzxZIm3hW697HOT+tDoQiYnP0I/BNKs8iR4DSA/N8WIYq3hIxqKUCiH+LSK8qPypbu/erB9Fsf8sllKCa33uF4Y8Z9eoL7lawpvIlRoKINe5XjqLQy0/k9hdyv9D+6tOAPMbZEj025U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066381; c=relaxed/simple;
	bh=mETvTRXF6VHY9zMnCD32eQbesm4Tc+3fdL1qa1YNbYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8eiOk6SRaeFNWeEy3FUSuGEGwAJvm81sUaubflIFSXIpD6M6Vo1WD3GFdD7VqI3/4gPRH6P3nwqPqtH1DYnAqv+aTDE9/+Z+uYgJTNijrZHoWLeW5m9WF3k0XdKOHDAqOBvlx+EldBwz3BCuYluffhLya6rcwoDPm48QGeH+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keYCTE+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keYCTE+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAA21F00893;
	Fri, 29 May 2026 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066379;
	bh=DoKHSghnTxv8S3QLNddszzUqaQvDqqf/WFprH6BXgYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=keYCTE+vnVo3qXj6X5rUFkDWg/ADhxccUC9DidvaR6t0Ix3/rqHEnTnBNQ5nhvULK
	 2URcVTlatAZmTQezK76owvgpfJjNhPXY3VpYdHZ5DcaHX+GofjyXTo1DVEptRBKWDZ
	 rb/ZJ3aGvs2y5WVcOGt/vB1KWIRD1362kD0/985Wv1jFZB/LVImrYZJ7stFCqBPC1J
	 WzaDpCyB9FxEZayjvmPSeweWi4ite9LR9PdLSm6WLqxGrybxLc9C64L/OHoCvGTJ2q
	 RVu1PSnpUkm1IceG3FOprhtiYr2G3FoHZITbUTcyupzV2++Dz/NFvqni3mUH2sJmwN
	 b0mmBBit25pTw==
From: SeongJae Park <sj@kernel.org>
To: Cheng Nie <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH v2 1/2] selftests/damon/_damon_sysfs.py: fix memcg_path assignment
Date: Fri, 29 May 2026 07:52:47 -0700
Message-ID: <20260529145248.84593-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9EAB27169F5D0F3D+20260529091948.1702421-1-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 17:19:48 +0800 Cheng Nie <niecheng1@uniontech.com> wrote:

> DamosFilter stores memcg_path for sysfs staging, but the constructor
> assigns it with a trailing comma and therefore turns it into a tuple.
> 
> Fix the assignment so memcg_path is stored as the intended string.
> This makes memcg filter staging and follow-up validation use the
> written path correctly.

Nice catch, thank you!

> 
> Signed-off-by: Cheng Nie <niecheng1@uniontech.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
