Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89D2820AC;
	Fri, 26 Jun 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433023; cv=none; b=FyEYyZrkEubtq8+e9yFbmF2k+dsi9/SKiVWp+8FkVmK8HOZqA5ZaWP0aCczOA28CNVIE1wOJ//O1tsgf8X6aV1FjbvVVPO+68DtWLahpzA+rPvw2Q5SxhgSOdIC3gUKhI4OxzhNZJzEKIDsX1aCxaEjREw9czT4KxKzqSfjerlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433023; c=relaxed/simple;
	bh=U83CuGGTpz/l3QnDhUGShfNAF1oKHyDrOUzyv1RWKCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8oCgYlAY5DQvtLMCGWLugrzNWT/zkyIBfKyZhSSyLedFe5ZbXnNSCW0+dpIGuxYM9BxqwZ+AZHPg6NCGKndM5RXCzk6yzytXD7iXFQrcvwVWUcRmh2npC+MyinDzNB4XsdX91zpGGjbIVKs/S84YT27LcWZY0nqDE8SfpSFfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOEykp8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOEykp8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC641F000E9;
	Fri, 26 Jun 2026 00:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433022;
	bh=o5OttG5aZqvfe3QoWDGJ8CJoxJmlu+HgiCPFZDVymoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOEykp8Aw4uSG4MkL/hC+myXzf5b/i6f4lWOYRGYw0UrtrwpIoObKUx8k8bDRzECj
	 04UfY5cs5t3evs/EauKc0MMeoa+grytqlqfAEjO2I7KxdAHk4X8zzUV/VJO6yB0EVs
	 BLui4h1dr7WL3v0BUmj6DKHKCKFH1YBoCPkPSqegWXWwwID8fcRDI9JHuO/oAm2pwa
	 UvLKIsYWih7X/5ekyQzAap8178gKbCWGU0IHgbiix2v1x+NmRVB9NjLsbhxrdIIAdG
	 4ZY3+KUyr9EWdw3C0S8qdqWmek83h0ai/YBkiVoOGXByl4cO879gOm75mVttd/Flan
	 +737vQcnTDujQ==
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
Subject: [RFC PATCH v1.3 02/11] Docs/ABI/damon: document probe files
Date: Thu, 25 Jun 2026 17:16:33 -0700
Message-ID: <20260626001644.85825-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626001644.85825-1-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
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
index b73e6bc28ea5f..f914aab79fced 100644
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
+Description:	If 'memcg' is written to the 'type' file, writing to and
+		reading from this file sets and gets the path to the memory
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
