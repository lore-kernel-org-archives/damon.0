Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36B223DC6;
	Sat,  5 Jul 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737811; cv=none; b=L1rCYtTgy/oZEA7KZovr3B/33MB8uxVDgCYfJtOj5qVRHrFRmbrRCOSrvoOZp/+NDnoKWxxvxwJoQY5pSM8cdJ2DaOD8lk6SPFwKx7KsHn2/MZBKWpAiE7eUaUhEp7dhPMgcnQt6cslbmSm1qL6mO/SRr+WlIDS+WxBO7OrFDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737811; c=relaxed/simple;
	bh=MRKp90zy+fE+PWnSNoK2r9DKEixr7CxXd4ejww/Kp3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKIbtPYYzNH+9F7yjTtR3IoqhS4VHPtUtY+dTpgXrzBIdVuQI3xHhKUpy8j1HgeNvlLTHcF3m97cIVy6RYNhyj0yBJewqev93OVPfWh8SSwpYUllHaM0yAdrvZpQIVWX7mj6iZX/VTj/i9i8t+pUEJ02E46teODPSAKbvYYyNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjJFbB/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjJFbB/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4DEC4CEF3;
	Sat,  5 Jul 2025 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751737809;
	bh=MRKp90zy+fE+PWnSNoK2r9DKEixr7CxXd4ejww/Kp3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjJFbB/TJgHOYYvTK4YKFHCIUHLhMNugNwmXSN/PoYsxblJdV9jSKbEBoC3WEWCAQ
	 H4WraXru11vTaJADsbmR3Dm60hIxQYGWidUqu2yowRN+RRfwjlMW3MDBgJjPdsORNu
	 r00b6pduZ3vLynjChv0HZU512cKsoTIgslhwimQWiE+dma2seS3kb6L5x5LCnNqJp2
	 yJyHjq8wkhy+qGWOaQ3riCtLFjRJlH7ZE8kXhKy9DvshmQxolZ7gF/OSQ9XnGe9Q4s
	 u17RRhawo3BvKqvDXZtJE5n8F0wUONIdVRuqvGM523wnAiPIaYP1GX+PlbLemwF9wN
	 qFoA1ti7wtdEA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] Docs/mm/damon/maintainer-profile: update for mm-new tree
Date: Sat,  5 Jul 2025 10:50:00 -0700
Message-Id: <20250705175000.56259-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250705175000.56259-1-sj@kernel.org>
References: <20250705175000.56259-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently a new mm tree for new patches, namely mm-new, has been added.
Update DAMON maintainer's profile doc for DAMON patches life cycle,
which depend on those of mm trees.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index ce3e98458339..5cd07905a193 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -7,9 +7,9 @@ The DAMON subsystem covers the files that are listed in 'DATA ACCESS MONITOR'
 section of 'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
-linux-mm@kvack.org.  Patches should be made against the `mm-unstable tree
-<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ whenever possible and posted
-to the mailing lists.
+linux-mm@kvack.org.  Patches should be made against the `mm-new tree
+<https://git.kernel.org/akpm/mm/h/mm-new>`_ whenever possible and posted to the
+mailing lists.
 
 SCM Trees
 ---------
@@ -17,17 +17,19 @@ SCM Trees
 There are multiple Linux trees for DAMON development.  Patches under
 development or testing are queued in `damon/next
 <https://git.kernel.org/sj/h/damon/next>`_ by the DAMON maintainer.
-Sufficiently reviewed patches will be queued in `mm-unstable
-<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ by the memory management
-subsystem maintainer.  After more sufficient tests, the patches will be queued
-in `mm-stable <https://git.kernel.org/akpm/mm/h/mm-stable>`_, and finally
-pull-requested to the mainline by the memory management subsystem maintainer.
-
-Note again the patches for `mm-unstable tree
-<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ are queued by the memory
-management subsystem maintainer.  If the patches requires some patches in
-`damon/next tree <https://git.kernel.org/sj/h/damon/next>`_ which not yet merged
-in mm-unstable, please make sure the requirement is clearly specified.
+Sufficiently reviewed patches will be queued in `mm-new
+<https://git.kernel.org/akpm/mm/h/mm-new>`_ by the memory management subsystem
+maintainer.  As more sufficient tests are done, the patches will move to
+`mm-unstable <https://git.kernel.org/akpm/mm/h/mm-unstable>`_ and then to
+`mm-stable <https://git.kernel.org/akpm/mm/h/mm-stable>`_.  And finally those
+will be pull-requested to the mainline by the memory management subsystem
+maintainer.
+
+Note again the patches for `mm-new tree
+<https://git.kernel.org/akpm/mm/h/mm-new>`_ are queued by the memory management
+subsystem maintainer.  If the patches requires some patches in `damon/next tree
+<https://git.kernel.org/sj/h/damon/next>`_ which not yet merged in mm-new,
+please make sure the requirement is clearly specified.
 
 Submit checklist addendum
 -------------------------
@@ -53,8 +55,9 @@ Further doing below and putting the results will be helpful.
 Key cycle dates
 ---------------
 
-Patches can be sent anytime.  Key cycle dates of the `mm-unstable
-<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ and `mm-stable
+Patches can be sent anytime.  Key cycle dates of the `mm-new
+<https://git.kernel.org/akpm/mm/h/mm-new>`_, `mm-unstable
+<https://git.kernel.org/akpm/mm/h/mm-unstable>`_and `mm-stable
 <https://git.kernel.org/akpm/mm/h/mm-stable>`_ trees depend on the memory
 management subsystem maintainer.
 
-- 
2.39.5
