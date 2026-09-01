Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146B486BA2;
	Tue,  1 Sep 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269123; cv=none; b=ShAyo75WrbNIoe8OOnjOwpBxg0sL+GUqUEK4YefuLrMEPrmnaEwRdGeLrLYurKw8tyyfI2o0tlW40snRC4SdIBubTPIymBoUMB5RW7LGjsr3WQYIuAc6opuiUmXEtQu8IeX4CZmxUtKoV1HPOM0CNJ7zXia5FC1P0mF3yr1yhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269123; c=relaxed/simple;
	bh=Pffw0QddcOdszpO6Pf+uRui7oVwqUV9y0L1CM1LEgZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEEGqRlKec0zjLzAWO8gVtqnNu88DPLyK4eQ5VDOzqY5ZcnVXf4EyIGV9gGxyEseCtBjZZ7ZmpBtYWw7GrW1vC2iJ7Vaa/hP+H4fzJDi9BEk5yLOXm68uIJ80yCmt5h0DkqIMe2f/AjNb/KTKuXv/zEZ96AqRrL2Y0+y93Yy9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWAHzePq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWAHzePq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0851F00A3F;
	Tue,  1 Sep 2026 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269121;
	bh=Zxj0qXZlLFjv8Oo1ubEI7gb1ZBWWHlkx56zIdj50cXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWAHzePqxkYp0mQOl5mchlLIrWkjoVoUA56rKm/nitPJvcwqwOS/ikOO0f9dnYC7W
	 1FhMnWdS2tNxJFv5PK/FxkMOaxuZjA5xg3a4M9Wc1dlnMp7BIv9ji354EXVVfXqIXZ
	 omT/3TmcnE1B+x+rkFApZiKtd2URQhnb35VvEScPmWKnXlbtFYH+XNe31nQlIbHltv
	 fbDjO9EUzpJv6nhzRCsDz2dt3vHwMpXGD2J/HFyiM0KmAEe22duc8CNT9XuOjVYxeA
	 rDZaKaVdevlUdNP03jSyA4Aern5jgvlBDPX92E+fvmn2RHvDRXzoKDkgq0j6/FeM1N
	 kZyvKgZvrwqPQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 17/17] Docs/ABI/damon: document probe prep sysfs files
Date: Tue,  1 Sep 2026 06:25:04 -0700
Message-ID: <20260901132506.99243-18-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added DAMON probe prep sysfs
files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e675a57145e36..f8d2601e82904 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -173,6 +173,19 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		per-probe attribute weight.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/nr_preps
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probing preparation action named '0'
+		to 'N-1' under the preps/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/preps/<R>/prep_action
+Date:		Jun 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the probing
+		preparation action.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
