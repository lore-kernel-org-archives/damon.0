Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5B1607AF;
	Fri, 21 Jun 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987794; cv=none; b=AGHFYJ4A+kAiRzqhBqyO+R/r4zGwwB1Ng+1EXfOrk+XoTtUVLOzGma+6l2Eu9pr3le0pBX9M60l0Hp9cAOFkdp9MudU9Q9c9GFqpbCL/DCVDDIiUo+1WNESMPn0PifMKPUTZRE1qZ7itnW++zBBSzywm1elvyFeBskEaEoEHhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987794; c=relaxed/simple;
	bh=ag+0LTSvLc7p7uZDX+MobUWjPrOwOdBj/IVIopBLENw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKPmgQB43VdIp82uEEW1Nb5C61BKEn/rnAzIhgUHnvogxBdgs595f1d7cdq0VZ9viYo2010yuMaBbjaTNnMQdZZde0hEvgZlSqVsoy5zWZLrlwqSDJnq0WG0T3bHvzGbkzNw180m+QOx7YpdJutxeWT+zJ938Zp8u7GijpD+RGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc4zEfVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc4zEfVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ED3C3277B;
	Fri, 21 Jun 2024 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718987793;
	bh=ag+0LTSvLc7p7uZDX+MobUWjPrOwOdBj/IVIopBLENw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qc4zEfVZNnBg2XbzQFMVaWNzba5Lb2AR7x1cjKKbPMm7+Mt3o+0gRADFEeX04DJg9
	 hwFmg23uXZJ38e6Xq9i0zj7K3vr9CPEGwK3QxFWRozF9LX/CndLlZfB2IOvOkDoV4B
	 L1Ir1me/v8eVWzmuRM6IT+dGOHU+4sSE8C8wmIa43PZ+RAgjliCspaCA34RetYnq4k
	 G9UoT6W4Goxu0gPVL4MbQYOmfpOOFQXbKz5IOeHs8Qs6CRWaqn4z5aJXPMGQFyTdpD
	 KuRQWtw2+NZYswdhNTqB52BQnmEBviBoPW233JqFX6L/L+sqNUEi+fVbG7xx7EwPiv
	 7APPyYdixr9/Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Docs/mm/damon/maintainer-profile: document DAMON community meetups
Date: Fri, 21 Jun 2024 09:36:26 -0700
Message-Id: <20240621163626.74815-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621163626.74815-1-sj@kernel.org>
References: <20240621163626.74815-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON bi-weekly community meetup series has continued since 2022-08-15
for community members who prefer synchronous chat over asynchronous
mails.  Recently I got some feedbacks about the series from a few
people.  They told me the series is helpful for understanding of the
project and particiapting to the development, but it could be further
better in terms of the visibility.  Based on that, I started sending
meeting reminder for every occurrence.  For people who don't subscribe
the mailing list, however, adding an announcement on the official
document could be helpful.  Document the series on DAMON maintainer's
profile for the purpose.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index c7db0572faa9..feccf6a0f6c3 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -69,6 +69,24 @@ In other words, ``hkml`` [8]_ is a mailing tool for DAMON community, which
 DAMON maintainer is committed to support.  Please feel free to try and report
 issues or feature requests for the tool to the maintainer.
 
+Community meetup
+----------------
+
+DAMON community is maintaining two bi-weekly meetup series for community
+members who prefer synchronous conversations over mails.
+
+The first one is for any discussion between every community member.  No
+reservation is needed.
+
+The seconds one is for discussions on specific topics between restricted
+members including the maintainer.  The maintainer shares the available time
+slots, and attendees should reserve one of those at least 24 hours before the
+time slot, by reaching out to the maintainer.
+
+Schedules and available reservation time slots are available at the Google doc
+[9]_ .  DAMON maintainer will also provide periodic reminder to the mailing
+list (damon@lists.linux.dev).
+
 
 .. [1] https://git.kernel.org/akpm/mm/h/mm-unstable
 .. [2] https://git.kernel.org/sj/h/damon/next
@@ -78,3 +96,4 @@ issues or feature requests for the tool to the maintainer.
 .. [6] https://github.com/awslabs/damon-tests/tree/master/corr
 .. [7] https://github.com/awslabs/damon-tests/tree/master/perf
 .. [8] https://github.com/damonitor/hackermail
+.. [9] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
-- 
2.39.2

