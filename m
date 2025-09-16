Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F6264F81;
	Tue, 16 Sep 2025 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993030; cv=none; b=b+zFFmjbrIQHS8un/EnTUxsaj643fK3KUOaYwTCKT78X6va9IPXb6GpCxGNlgqSCzuEu6kgNzBKBMz3uVe8UF/a2iY+J8gOItgB5FYNTG1qj9MQ2Sbxn/eeAdP6DD0E1xeEU9ByLdngkmaaQ6arnM8L+kQUQnfmGRr+hZofNUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993030; c=relaxed/simple;
	bh=fXqWEV0uteJHKreZswJU4z83HZDt1wWX0HDZmnnr9U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iK36bKORD+kU52rY+zeNK1by3AK6sTPEUO358uDkn9wE5QVuffTKSKWqO3PEUkooHNthuMitckjeNRUJL2b5Bf2L04mja2JCS7N5lGcgVrr1PXo/E6aSG9Dc2BHZMLXiRQDwMcix7zp8k91SRDcpP5u4AynXsTK3RG9wbppkXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSNOpY9E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSNOpY9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23500C4CEEB;
	Tue, 16 Sep 2025 03:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993030;
	bh=fXqWEV0uteJHKreZswJU4z83HZDt1wWX0HDZmnnr9U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSNOpY9En5PPKq7BhuMKnwmUct9FEB3c3U9+vRojAfOn47R+RmnvF7BBhxGnHm3M6
	 QttjWrxfpS97VzY3lvc2OXbS1yru2YRvRVW/vcsGwjJTJ5tAj+i82l0nixlApj76Lm
	 YgVkkKG7+zqe5Px/8m13jmks+aXCx6B/uQK/w5hPpPyjfM1HpK23UymTXuzC8L/QPE
	 2ok+KdSBaaFcFEmQc62CohdRT+hMjCpWw+zV9Rcvz4AlEE1CGm4kaoh/t2nDxEdMTx
	 CvDBOpXCsMTib7J/LXO8r+LBE5kfHIg8eldRgn5mHxMwK4R+SJAWoXIhxqdNgnIezT
	 5QQV3Vbfzr2Uw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [PATCH v2 3/5] Docs/mm/damon/maintainer-profile: update community meetup for reservation requirements
Date: Mon, 15 Sep 2025 20:23:37 -0700
Message-Id: <20250916032339.115817-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916032339.115817-1-sj@kernel.org>
References: <20250916032339.115817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON community meetup was having two different kinds of meetups:
reservation required ones and unrequired ones.  Now the reservation
unrequested one is gone, but the documentation on the maintainer-profile
is not updated.  Update.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 5cd07905a193..58a3fb3c5762 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -89,18 +89,13 @@ the maintainer.
 Community meetup
 ----------------
 
-DAMON community is maintaining two bi-weekly meetup series for community
-members who prefer synchronous conversations over mails.
+DAMON community has a bi-weekly meetup series for members who prefer
+synchronous conversations over mails.  It is for discussions on specific topics
+between a group of members including the maintainer.  The maintainer shares the
+available time slots, and attendees should reserve one of those at least 24
+hours before the time slot, by reaching out to the maintainer.
 
-The first one is for any discussion between every community member.  No
-reservation is needed.
-
-The seconds one is for discussions on specific topics between restricted
-members including the maintainer.  The maintainer shares the available time
-slots, and attendees should reserve one of those at least 24 hours before the
-time slot, by reaching out to the maintainer.
-
-Schedules and available reservation time slots are available at the Google `doc
+Schedules and reservation status are available at the Google `doc
 <https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`_.
 There is also a public Google `calendar
 <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
-- 
2.39.5
