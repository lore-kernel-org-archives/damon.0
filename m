Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667589;
	b=YXxZWSNETYuW+qeAxdKjt94d7dZMCusOg3kl5UokgIqz8dRovc22GmxXyr3dmZzT4681
	 gCbnqfJI3MrFsTbx3l3VL3/NRBF2moh3sjAJANk5LXJwcGcrkd3VQPOiAsvT4RiN+uHKz
	 i04rMCrX5cUJlsEdwINjzQWtdd8lJX9yM7t9DuKAd5GDXifrOmRxvgDEXmCXP5CFBnxvH
	 nR9euCAb/I+SNDT4o1fY+4Tyk7DLU/V/vjqNvpo4l4NRqw1aPcQWim96/ypZHWd0KF8Kg
	 bf05lKcVDnl+Gd3rE37S9JPNmVAGEmWIF8lwH+Tr5uo664AssOgwsT1znXd1Ac0hnMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667589;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EMQGjxX/eZN26RByAXsUy+dO4H0OBRJHaPdwIJ0/2MU=;
	b=PkkGSJpZXWIJUwGm9XNaWTu5AfMoV8R+kTfEMCiLqW0ZBtrRXX0QrhmTCyNCN+wjee8P
	 29T+ZeqRis9M+9FpYDjFP4LywX8MoRkdW7rYNJXp7R9PJSpfjkUXkyg/GYgw9Ze0CzSi1
	 IIOcehz0/ruzJTOkNAE5bUEva01EeG6JCcsJTD/O0E6RhV+y76Hrg9+suIoSR3q5XmBRA
	 1CTR+wwObO9srqB6Bpli2cT2gpQE09BQr7Zki2i91D0D/utQU3uXn5JVFUm5R8PLrSqse
	 TiWnzdkblNayiAmw6XhoJG4faXFWPTNE0D8zQnFqCwiC93k88sbpLaBixRFa/kAnxNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY+eryAC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53F606A32F;
	Tue,  3 Nov 2026 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY+eryAC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02F71F0093A;
	Tue,  3 Nov 2026 00:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667588;
	bh=EMQGjxX/eZN26RByAXsUy+dO4H0OBRJHaPdwIJ0/2MU=;
	h=From:To:Cc:Subject:Date;
	b=bY+eryACEl2Ju3rGWOXwGtk5MbSLvqeAcb/qqLxVlU62vEpTh2HLpsmBKL/zUq7D5
	 26Kdf1ec1fuUK7tv+vNuoWVWRK8IJj6m9hMt1xC+F7/+mISoOjVxYfDW0tIv0AKXJ3
	 b1uNohESqo56M4nLrC2IqaGCzllo+wB2zwC80cCrz32LImecIn2adQws5mExeLvcqp
	 uQaASCxnuEfnN8pTwVGNxei6Js0aAAq/peDeF7xPSHQo9y36a5PatTEb0CgXq1mAEV
	 SyItyvRN3/lyRcER08WcBak1H0eOVjP4SezxxyAcD40GweZYvfrVK1x9bDIo+v3iTU
	 Msbpvhy1aIYfA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/8] Docs: damon: fix grammar and typos
Date: Mon,  2 Nov 2026 16:59:30 -0800
Message-ID: <20261103005940.91432-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

I was reading the DAMON docs and kept running into small grammar
mistakes and typos, so here is a series that tries to clean them up.
There is one patch per document, and nothing beyond grammar was
changed :)

Some fixes pushed lines over 80 columns, so those paragraphs are
rewrapped.  Patch 4 picks up what I think was left in lru_sort.rst
after Manuel's recent fix.

Changes from v1
- v1: https://lore.kernel.org/179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com
- Update for Manuel's suggestions with S-b: from Manuel.
- Collect R-b: from Manuel and SJ.
- Rebase to the latest mm-new.

Aveline Noir (8):
  Docs/admin-guide/mm/damon/start: fix grammar
  Docs/admin-guide/mm/damon/stat: fix pronoun agreement
  Docs/admin-guide/mm/damon/usage: fix grammar
  Docs/admin-guide/mm/damon/lru_sort: fix remaining grammar
  Docs/mm/damon/design: fix grammar and typos
  Docs/mm/damon/api: fix verb form
  Docs/mm/damon/maintainer-profile: fix subject-verb agreement
  Docs/mm/damon/monitoring_intervals_tuning_example: fix grammar and
    typos

 .../admin-guide/mm/damon/lru_sort.rst         |  45 ++++----
 Documentation/admin-guide/mm/damon/start.rst  |  16 +--
 Documentation/admin-guide/mm/damon/stat.rst   |  12 +-
 Documentation/admin-guide/mm/damon/usage.rst  |  31 ++---
 Documentation/mm/damon/api.rst                |   2 +-
 Documentation/mm/damon/design.rst             | 108 +++++++++---------
 Documentation/mm/damon/maintainer-profile.rst |   2 +-
 .../monitoring_intervals_tuning_example.rst   |  28 ++---
 8 files changed, 123 insertions(+), 121 deletions(-)


base-commit: 05d3ad215b277a02bf20afb9b30ff2bd15e8e9c2
-- 
2.47.3
