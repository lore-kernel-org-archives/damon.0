Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289622;
	b=pw8nbiC8XRMNWJUKu6HTj95OH9oGIdDZOkL2H7tHwysAwx19dPT0+8cut9xuKaefGzt+
	 F6unRMxpOOE0RKeD1veRS4ZFAVFySi3e6i4we+NOt5klcEKlIJku99bqGB2DeN5U251Uu
	 /RYIenEiLi7v9v0nDKfmKa+cAj4FmMOMZ+WYQFu9b9m7SWMvRh66LRtecT+rLE3vfx70a
	 KZRq+TcTJqM6Ou/70CYH8j5HglPLLlgPGlvLbiFo9msJOZY2wSGuP3DklSMCcrb0TaDmd
	 sgQBDCxvRBNbjVD1kz0HAZ8PY8dHGNy4831EIA3paAbRbTyrwNA3s90cBzTKo8mWe1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2qZsGR/sLdn0qLTF/VW/uayeEPi0hmDXZwV0zU4xgig=;
	b=gzMnG0tZmHnW3R7Toy9Kth7GJofn/TQd9gBfYId7cQW97G+8NAg14sJcL/L9yaBrW+1c
	 IXE5qpExO5Lib0J8hRxEglG/Wm9KswoCywpgliInepqo93lNPdhcOGkqmNrAkYEm3gR7q
	 ohELUtibIECA6e6NBECXBmwgV9EJ0a3uOddzfbY1LFm08Z3Ls1+tlQPG/UJLyJxgRiXQQ
	 2Jpyl9YaB9s4DTZyc3bxerydlGJw1Muv6B0+FuvRll86iWRxuoaxs0YvEgzDc9XOz76eS
	 rxwPLD7w4l0BDFYPJH/1t4lc7zMgf+85BOduV5VxEVVyRrO68dHZ+2cMVAacpUYNabQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DlA/uZOO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAD606A320;
	Sat, 21 Nov 2026 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlA/uZOO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438C61F000C0;
	Sat, 21 Nov 2026 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289621;
	bh=2qZsGR/sLdn0qLTF/VW/uayeEPi0hmDXZwV0zU4xgig=;
	h=From:To:Cc:Subject:Date;
	b=DlA/uZOOmMwj7/yI/xq8L5MHTwnnPePC4ZNk7K9kI5dR+rAmqBDBa6Qi4GrTbRGhp
	 b6b6Z16CZSWJSduDm9o3gEa+9WynORueGdk4d7m9cnhb5WDEvaQomnHTyOScvsn0v3
	 S5NahacjGPWEh4dhbPtF986GYgcAc6F6EVU3pTY4+78vDMQvgKqOjfKCUxmFgJN4At
	 4yM1aLJcfId44XVngK5Ux8D0dcSbNREpsrtY5npFjaLu/pyT0QfCDyz55mvyEGUG0U
	 aFuAWQK0IbZuOjcw93+8XHpsHdo1Wo+QgI0J7/8FhiqIWDJfO59/kkcran1pKRF/8H
	 tmIrDNVwEDPkg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] mm/damon: update documents for mm-next onboarding
Date: Sat, 21 Nov 2026 11:33:25 -0800
Message-ID: <20261121193331.108587-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right after the 7.5-rc1 release, DAMON will onboard the mm-next
transition [1].  The major change is that it will use mm/damon.git [2]
and mm/linux.git [3] instead of sj/linux.git [4] and akpm/mm.git [5].

Update MAINTAINERS file to capture the change, via patch 1.  Further
update DAMON maintainer-profile document for the change, step by step,
via patches 2-4.

[1] https://lore.kernel.org/bed81e01-7303-4957-bd7d-38e3a094e96f@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mm/damon.git/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/mm/linux.git/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

Huge thanks to Andrew for his tremendous mm.git works that raised DAMON
up to the current state.

SJ Park (4):
  MAINTAINERS: change DAMON SCM tree to mm/damon.git
  Docs/mm/damon/maintainer-profile: use damon.git for patch baselines
  Docs/mm/damon/maintainer-profile: drop 'SCM Trees' section
  Docs/mm/damon/maintainer-profile: update key cycle dates for damon.git

 Documentation/mm/damon/maintainer-profile.rst | 57 ++++++++++---------
 MAINTAINERS                                   | 36 ++++++------
 2 files changed, 46 insertions(+), 47 deletions(-)


base-commit: b0ddc1203e3d7a63e712e8988a03f98dbb179904
-- 
2.47.3
