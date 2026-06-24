Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AC3C10BB;
	Wed, 24 Jun 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310826; cv=none; b=J9zvEYaGinppzcw0wGGUcKZE/45rBUVwKNcwRPFS4vVCJZtGzhWT8w7PcDoOMX9whe2iugWaIWdr9M7uAWyYsSwsU4My3bJ9PosSFCnxrPBsfiIDQWVWRDq3ULZtfZUpBt1sL41BxtKwj9YMK3+s6xCbWswjsyl9cx2hyadx0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310826; c=relaxed/simple;
	bh=uOiyrJxsccXEayG3zZdWsgShhfLJR0Pfi1nhu3l4yiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YORvvA/LC5Nvm6SMGZoXcm1QsJwen4GMRYkS5UA6RU0+4VOYWw3A8f8KsNN+O9904aA0fstOBBB4EkGbnYjcbi3B49Hkr1oR9F7o7Uy5hmHExfEb8D7lNjYlw0Q8BN5K0erUXmR3vGXhx2eqLEEJL9UQ5rvRI4IS5RjFCi1Thlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjzXCQu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjzXCQu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556B91F000E9;
	Wed, 24 Jun 2026 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310824;
	bh=ARqAM43ohvafn9UnTqgU4RPIXqjonzaqaC6qJIpJbfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IjzXCQu++yR1i3ggwiu2WUOZOwR0zBCvwDCxPbAa9CbdTd7CB9Sd/83XmklRrdxC3
	 7LzNXSoVWDZ+hcviXzTXVQXDcVpLIoukQJ2g7zHwfc2TRxlbcZuFaLwoIw9S2fBby/
	 JD8qv4UHoVfDCSBmFfzOq9jP+s8J60Cw25r2rIvsWJvWPtGEFYx3WVx7vTTDUnTIo5
	 d2r1o0y27pac5Lrw0IxlZxfso649hocAiUxlhl2O3jsYj15kaa1fyLHK7aPBz5rBEW
	 cPCytv5OGS4gfs3KmsR71kdIDbBR+BHST0wf8XKbu+KjmXyyUc2QzOc7aIlHRWGxPA
	 E0+dvG3FZMTug==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/11] Docs/ABI/damon: document probe files
Date: Wed, 24 Jun 2026 07:19:58 -0700
Message-ID: <20260624142008.87180-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON ABI document is not updated for the DAMON probe sysfs files.
Update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b73e6bc28ea5f..2815f6bc05c18 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -157,6 +157,46 @@ Description:	Writing a value to this file sets the maximum number of
 		monitoring regions of the DAMON context as the value.  Reading
 		this file returns the value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/nr_probes
+Date:		May 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probe named '0' to 'N-1' under the
+		probes/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
+Date:		May 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for each DAMON probe filter named '0' to 'N-1'
+		under the filters/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/type
+Date:		May 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the type of
+		the memory of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/path
+Date:		May 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	If 'memmcg' is written to the 'type' file, writing to and
+		reading from this file sets and geets the path to the memory
+		cgroup of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/matching
+Date:		May 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether the filter is for
+		the memory of the 'type', or all except the 'type'.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/allow
+Date:		May 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether to allow or reject
+		hitting the probe for the memory that satisfies the 'type' and
+		the 'matching' of the directory.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
