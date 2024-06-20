Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772213A26B;
	Thu, 20 Jun 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921023; cv=none; b=X5O5gMfnKuiEaOoJk2Ph2rvGUCRzc8vOyrVJWXoqCfeZosmo6uxfdaohkadru1M/cWMN3mjBeB4yxnAoGlgHl3nzyiSa0wL+uYrl7ZnVDB3hAuVOJe1YYvLHPEHcI2M2cEht5eRAg20yk+ygkrlQVc9+aQnBggaSoUmg8ZYsUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921023; c=relaxed/simple;
	bh=APIZ1aijkETcDT9yemVAjpSl6m/3vZEIvCxwRfWnjhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKqa1j75ai8woc880sIAJeCg8KtnhSII1Yuz91KECbUwafSgwLHeNZ692RhKRtSTyT8sKP63LNU87P1aaAr/+t35VtpVDzNGqoti9pZUK1VLdgHPwi68X9AkHRPdk1RqaCqijcMafuf6AiCdpnpxsihMRY9fDZj+wlpYRE7ilX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8rEuT0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8rEuT0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAE8C4AF0A;
	Thu, 20 Jun 2024 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718921022;
	bh=APIZ1aijkETcDT9yemVAjpSl6m/3vZEIvCxwRfWnjhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8rEuT0AtHS/sHY9lNdYvLvvm/Kjo9fl8zHEVqx2fjUiXGyzyxKddwsh7wtNdERXB
	 6MoeeyshK82a1ZEVsTy/WRJ9WwKso2EfvAjrntutUcrJrtZOfcHsFAFWgVN1pvcPu/
	 7QsMnf9INU8AfKmRWpZzpCfCwK8HpZvEM48ypuwYzpjuoCKxcyJ5QHNhefPZFjOgKD
	 d8Fi+k8Q4Gi+BaNkIDn5LB8LPeVtR98xFbzzXP1mmNhrx7OVyBL6fv7gqEKomy3gwz
	 UZCMUOXDyoz3mvtkH/v6IXJKj8/1V7O5xK4l3X6II2LgJUXapUf71012tYoA42a+uk
	 A8PbUrE5dsBcg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Docs/mm/damon/maintainer-profile: document DAMON community meetups
Date: Thu, 20 Jun 2024 15:03:37 -0700
Message-Id: <20240620220337.76942-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620220337.76942-1-sj@kernel.org>
References: <20240620220337.76942-1-sj@kernel.org>
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
index aede61f2d6a8..365258aa77ff 100644
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

