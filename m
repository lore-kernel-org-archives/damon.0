Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF92BEC4E;
	Thu, 23 Apr 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956582; cv=none; b=j+tAzaBdN3J1WkZF9pO7e6kXOndvgbQ1yPW3X+nikA/eOjUpOchUPVLFouG00N1JlEtARC5f/h8A+NhR0HYRwx+Jkt8wW1B0u2x0/IVPG9nNv8KrcMF64VboehXopkxUOccWrkvAgRpo2VBUCy7HoRHkOT3g/v41ME4WxsitlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956582; c=relaxed/simple;
	bh=rQtJyg98FPKQTGRAUXuSfYXDH7AOf6p1ENCuefnOVK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4kPQud34+p++g4aJX0ILurlcLQ7CZq+SAGmJI5hf/hjd2CzmkMhOqN1IoAs3VC6FfcAko72npMefEjL9tQ6cgUjpIfjnip7iP2eUeIkBxlLEUnsByOMiRt2zSi/Yl+G6+mVQSJiGcN87qbKbfhcYPXVIcIG0kKg3ET9WKAXIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9++1bKZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9++1bKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D6FC2BCAF;
	Thu, 23 Apr 2026 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776956582;
	bh=rQtJyg98FPKQTGRAUXuSfYXDH7AOf6p1ENCuefnOVK8=;
	h=From:To:Cc:Subject:Date:From;
	b=s9++1bKZIRQFMWLOYuaJsuL4IQQDmbqEmbx20BBr+2XLP36ZgEIDUA+1dQrUUALOm
	 Xup12QRFQ/4GBYsi2Pye3ObpCvg8lsOi66YlxwFJHaalagYQ7AC0t5lkhLBmHtauhP
	 PzPZREJdJbzgYgHp9/M88z55JDauXRC1h10GYZpjFGVuBwcs3iz1fGBMtH6VpT/Ji6
	 JffDgyRxI/KvdvvVyLnKn0vJ2ABb79MS3NmWevwQNgZUzVzFx7XOkWnbuRngbZ7x6L
	 EOBiY/+kSlzqC4WsErkL/NdNZWFB7fDbNyNSZXd3zXXm4tAzx630bUan5ruymYMVJ5
	 g9/ZVHGxQ3C7Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/sysfs-schemes: fix use-after-free for [memcg_]path
Date: Thu, 23 Apr 2026 08:02:50 -0700
Message-ID: <20260423150253.111520-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reads of 'memcg_path' and 'path' files in DAMON sysfs interface could
race with their writes, results in use-after-free.  Fix those.

Changes from RFC
- rfc: https://lore.kernel.org/20260422144059.72000-1-sj@kernel.org
- Fix a typo in commit description.
- Drop RFC tag.
- Rebase to latest mm-hotfixes-unstable.
Changes from v2
- v2: https://lore.kernel.org/20260420125405.362137-1-qjx1298677004@gmail.com
- Split patch for individual fixes commits.
- Hand-off authorship to SJ, give Co-developed-by: to Junxi.
- Use mutex_trylock() instead of mutex_lock().
- Add RFC tag for Sashiko review round.
- Wordsmith commit messages.
Changes from v1
- v1: https://lore.kernel.org/20260420085332.178473-1-qjx1298677004@gmail.com
- Protect not only user-writes but also user-reads.

SeongJae Park (2):
  mm/damon/sysfs-schemes: protect memcg_path kfree() with
    damon_sysfs_lock
  mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock

 mm/damon/sysfs-schemes.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)


base-commit: 26232ccdfcc7029d92b633b01f5f22913ab72168
-- 
2.47.3
