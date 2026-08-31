Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD66513560;
	Mon, 31 Aug 2026 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188558; cv=none; b=DvTv4Wdd3V3JTsh7k5WUwWPrpxoRovfd540XOq1uVaCDPdEQO3JwON3qAUpsTXAjkijk3rO6VfJ4bxqgrm3PtXQW+k6TcfD2xgRdCDiZySGSKxlOx9kd7W36AmGUpsj5HvAi8jhINdEmFU6KEx8uyGBjxV6SP43GWNNLRhIOv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188558; c=relaxed/simple;
	bh=lK0Y/Z334Pbk0QqzoKJO2Co5YZywBcoe4QWXecs3BKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arzGh2MyQBnXiYg/SpJKuby1GFYWthPuFsmJZLO2XXGar4y0S9qKBEvLMUGeIL7Sipot8G26rYiYT76Zb0R6aCTiEXymymu4m1EpPYujPu847n71LabK58V4YUqMVCVSFtN3AyVBos/EPgJANKPdZJJ6HsmCvX6y/V0YHBGIVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K67QxRPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K67QxRPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9A51F00A3F;
	Mon, 31 Aug 2026 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188556;
	bh=yXn4FOiKb4JIWcSHZNBTe6EO/erUpMh++SEHXjVqCNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K67QxRPWwOvBzIuBi7VnzhsuXPxPepi/qpbAN0usUjIR9TeEMc+UwvMUAnDamy07U
	 lw0WLuJjhWOPchA+iSwH/5ofeDhdsqFVq0kawpyRUGNjla7c9JvDfoW28/7ALet/5v
	 rgMu+miDMDpojnONyalNpbR4UHz76N2Cc4g///DEOm4v2UaYykh35UvVy64oh1AQfZ
	 ihlTSC/9Gk+dVFsQvfnZh/4/qA1JySu1qXkqdalz2fttrXGC/CkGce9LtR9zNkYvTb
	 hsebKie7WeST3NOGnUbdrA6T/Fc/jUSjnTkgHq0RSJoojP19XsPto1R+oyx7ry7TiF
	 6a5Ko+15QDoyQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/3] docs/mm/damon/design: difference between watermarks and nr_snapshots
Date: Mon, 31 Aug 2026 08:02:25 -0700
Message-ID: <20260831150227.83416-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831150227.83416-1-sj@kernel.org>
References: <20260831150227.83416-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Explain the difference between nr_snapshots reaches max_nr_snapshots and
watermarks.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index af94fc27890b8..74170a2285501 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -874,7 +874,8 @@ the action to the region will fail.
 
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
 non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
-scheme is deactivated.
+scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
+``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
-- 
2.47.3
