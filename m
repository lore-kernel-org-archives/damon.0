Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685932D5CF;
	Tue, 16 Sep 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047491; cv=none; b=ZHZ2Z8EjE3RhOb4YRi6pVrUGiPSxAWfo+HFMmKQGGoQ4AN1GpP074fFXAjcFcRWb44NT25KZtd0H+9nbcWL9zA7fUNnpwP2SBpb5Mj0T5iHIEqKBz059ZI9KSttX0rkgY3P7XEHrr2NiiqCujG6LVCpKL7xd/Axn60Mz5mO1Ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047491; c=relaxed/simple;
	bh=zRA7NzE2dfOJUv7we74p+H9MxXbTZALm/bBalZg7Shw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JeHxZoAwDRHysU7dJoR7xey0IPQTnErVsopQTVHPOTxXI0Zn5I88xzHtVivtXKss8ld6farXyvF30XGv0CWoW17GWeYHGz17RsDvjykab4Noo5T5qDu/9q86VZ+b6OcLT+8IxhXPZvK9LJUYHPqC+aTmDdqn6Fy+RrUidsJhzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9gb090R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9gb090R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA99EC4CEEB;
	Tue, 16 Sep 2025 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047490;
	bh=zRA7NzE2dfOJUv7we74p+H9MxXbTZALm/bBalZg7Shw=;
	h=From:To:Cc:Subject:Date:From;
	b=A9gb090RsE07mCO9Y33W/36nq4GLOSQVtHGp+4RNpeKz96L1yb8NUM5809CbwhRhN
	 IxmkXRoJL9LJBtYW8PNSiCMb+C0wRjwa6Vvzwy3w9+CqKJTJK/eJ7IgbjpUqJuqxs1
	 kBa5QnQrlM+Gdx+iZ7O99oOSbab8DRCV+dljqnZcDyeOqPJUq2t7WgbzP4avJ/D9L9
	 4Ut5iyrgsFTWrUzSWnoj0ql+UkexNrn1YZAYyAqS389OOhSzTWef1ZE2bSRYBIPgiM
	 367w6e3Y9Vf47Cb6YyFvKam+Bs5P5Jmc/3tKQsWrEQ3uDYS1Z9WSaC5JzIREKSZvK1
	 eQ5Vj07ObeI+w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/stat: expose auto-tuned intervals and non-idle ages
Date: Tue, 16 Sep 2025 11:31:25 -0700
Message-Id: <20250916183127.65708-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT is intentionally providing limited information for easy
consumption of the information.  From production fleet level usages,
below limitations are found, though.

The aggregation interval of DAMON_STAT represents the granularity of the
memory_idle_ms_percentiles.  But the interval is auto-tuned and not
exposed to users, so users cannot know the granularity.

All memory regions of non-zero (positive) nr_accesses are treated as
having zero idle time.  A significant portion of production systems have
such zero idle time.  Hence breakdown of warm and hot data is nearly
impossible.

Make following changes to overcome the limitations.  Expose the
auto-tuned aggregation interval with a new parameter named
aggr_interval_us.  Expose the age of non-zero nr_accesses (how long >0
access frequency the region retained) regions as a negative idle time.

Changes from RFC
(https://lore.kernel.org/20250910040022.168223-1-sj@kernel.org)
- Rebase on latest mm-new
- Wordsmith commit messages

SeongJae Park (2):
  mm/damon/stat: expose the current tuned aggregation interval
  mm/damon/stat: expose negative idle time

 mm/damon/stat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)


base-commit: ae4745146347aef91dc328d1d9a39f0643ee244d
-- 
2.39.5
