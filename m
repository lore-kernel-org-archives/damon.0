Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977419046E;
	Sat, 20 Jun 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973616; cv=none; b=pNPoN4i5F8F9WsUQqxVJouEUUGQxMejpkzQM6QLOx45KsAI1rfbT/LqOiTa925DSteqtbi31onj2a9FlvMyKTE4npXNzApP2FxAKujsRvUNvoLId7ae5kVnAUQh2MxpKfWSUeYEQGtCbwr0y1b4Fd514SKhCKZwu1Ypjjwdyygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973616; c=relaxed/simple;
	bh=GupCNcDvT09p/tOkTTU9SAA6TepQZBzsWnHUsLqLu60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYyZdzMaYcmUpeWIkDHpkn3Yap7u5Gle08nzNAewkAWcoqJxTEjNjctmCMAS/OA0X3P9k1fK3BUSqfmQSyjqBPV/9LEYuzQsw6WEz+Y+tskz2jChRIb9I+bPQzNQ66xXkV5G+yU1oNCR5NFzrGgPNJUz4W3ZStP5lNqh4ZtMqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrVAq62v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrVAq62v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C331F000E9;
	Sat, 20 Jun 2026 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781973614;
	bh=K3Tz63BYosudJXEAdf0pGSRWDOvFsB+RMzyuu6FMqT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrVAq62vSWFLQklq1qa5DFRnbMwx/c1iX94ULGhFh3RBPLXHL7R8KBH+yClvSu6ZA
	 OQcMDYm86MenTTq9HurbEtizZM6Qj9nUyDZQNOf3NEjkIz+6ZFIKCiwjxFisTeYZrC
	 U3mGZFP2y+IygUGbNeX8JXTO4XAcwEsrhTsedNly3sN5SE/7AVumBaHTD7qi0wtJKX
	 ATTjbUnaFX5ZKlTkdnStARbZIPzRmH0bGuvad0XSxbsrnHjLd9uM1tnsTZnFz1fYKj
	 juwtfP1ULL6wMQqEBDWZfh7WVhVDQuArljVNKFWqnEt34ZN+SHa5ACgMv5X2JApHon
	 eid1GKN1ZUJrw==
From: SeongJae Park <sj@kernel.org>
To: yahia <yahia.a.abdrabou@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/damon/reclaim: fix potential memory leak
Date: Sat, 20 Jun 2026 09:40:03 -0700
Message-ID: <20260620164004.86461-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620032931.14281-1-yahia.a.abdrabou@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yahia,


Please answer my question [1] to the v1 of this patch, before sending new
version of patches.  I will not review your patch before the discussion on your
v1 is finished.

[1] https://lore.kernel.org/20260620002614.83004-1-sj@kernel.org


Thanks,
SJ

[...]
