Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C31A08A4;
	Fri, 11 Oct 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666121; cv=none; b=T57p9z9bz46t/Ok8ieTP/hPcYAQC/q/bDm7mx//HexDb0xTcn/rMjkBcARYwzqrEF5b3f/y1remjdHf5836CGTQhHHSQv3Rggm6eE1HK1LqSPTgo6kNTEHHajy3Z7hdJ+tQFlkgokz4Wsl9mrfefO1eduHk8yMyYdsZQMUVQ5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666121; c=relaxed/simple;
	bh=FjXH2IdgssaC1VgXM6fx4nfSiv/SdPLDBW6J9dj7vPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5WOw1ADWvwabDOb66Jvt2YjiiLFkhKvxDJZWi4hEMD/5oXoArnSUODN3sELIWe/qoJRoG9uSC8ArjmaxGPtHn8MnItEwcIRaU38vO2rVWDuRhgboYNadfbTZnDCfwVdAo4XTPmbxPMqgT6tIe6BahQflfQDkdwknkzBynOkuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz7ElFMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz7ElFMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD6EC4CEC7;
	Fri, 11 Oct 2024 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666120;
	bh=FjXH2IdgssaC1VgXM6fx4nfSiv/SdPLDBW6J9dj7vPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pz7ElFMXs98kV5oWdTgn2kWOqsnZsHnS8lRDD9ta6E7iwKvPk0jmqUZ9agQ3561Fc
	 xwu53EFSDBxBnq4KaD4NRW46/8wTqDaq5E/bPmqRv+zgnYqpCHJ/ha5YjZClCZR28X
	 apORACKmS50zeNRZyi9t2A8QDbGUr8tEVuq2kJBm0TChSTo6hjxOtNQ0W3YdlIfSCB
	 Jnmlju5wccl0h3Inx0gfNM3Ce6e17XHTutvyX5HAjgowpcydb6TxvcAlxfr2aUmWB+
	 kfEOA4t5ndanGTFpbus32wwIE1RXzhmV7pZH0vJXSY+MQDkC7hHnEQK4eaackgtzoh
	 06h/bRaa2vz+A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Docs/damon/maintainer-profile: add missing '_' suffixes for external web links
Date: Fri, 11 Oct 2024 10:01:53 -0700
Message-Id: <20241011170154.70651-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241011170154.70651-1-sj@kernel.org>
References: <20241011170154.70651-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Links to external web pages on DAMON's maintainer-profile.rst are
missing '_' suffixes.  As a result, rendered document is having only
verbose URLs that cannot be clicked.  Fix those.

Also, update the link texts for git trees to contain the names of the
trees, for better readability and avoiding below Sphinx warning.

    maintainer-profile.rst:4: WARNING: Duplicate explicit target name: "tree".

Fixes: 2e9b3d6e2e59 ("Docs/damon/maintainer-profile: add links in place")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 2365c9a3c1f0..7b966480c79e 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -7,26 +7,26 @@ The DAMON subsystem covers the files that are listed in 'DATA ACCESS MONITOR'
 section of 'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
-linux-mm@kvack.org.  Patches should be made against the mm-unstable `tree
-<https://git.kernel.org/akpm/mm/h/mm-unstable>` whenever possible and posted to
-the mailing lists.
+linux-mm@kvack.org.  Patches should be made against the `mm-unstable tree
+<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ whenever possible and posted
+to the mailing lists.
 
 SCM Trees
 ---------
 
 There are multiple Linux trees for DAMON development.  Patches under
 development or testing are queued in `damon/next
-<https://git.kernel.org/sj/h/damon/next>` by the DAMON maintainer.
+<https://git.kernel.org/sj/h/damon/next>`_ by the DAMON maintainer.
 Sufficiently reviewed patches will be queued in `mm-unstable
-<https://git.kernel.org/akpm/mm/h/mm-unstable>` by the memory management
+<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ by the memory management
 subsystem maintainer.  After more sufficient tests, the patches will be queued
-in `mm-stable <https://git.kernel.org/akpm/mm/h/mm-stable>` , and finally
+in `mm-stable <https://git.kernel.org/akpm/mm/h/mm-stable>`_, and finally
 pull-requested to the mainline by the memory management subsystem maintainer.
 
-Note again the patches for mm-unstable `tree
-<https://git.kernel.org/akpm/mm/h/mm-unstable>` are queued by the memory
+Note again the patches for `mm-unstable tree
+<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ are queued by the memory
 management subsystem maintainer.  If the patches requires some patches in
-damon/next `tree <https://git.kernel.org/sj/h/damon/next>` which not yet merged
+`damon/next tree <https://git.kernel.org/sj/h/damon/next>`_ which not yet merged
 in mm-unstable, please make sure the requirement is clearly specified.
 
 Submit checklist addendum
@@ -37,25 +37,25 @@ When making DAMON changes, you should do below.
 - Build changes related outputs including kernel and documents.
 - Ensure the builds introduce no new errors or warnings.
 - Run and ensure no new failures for DAMON `selftests
-  <https://github.com/awslabs/damon-tests/blob/master/corr/run.sh#L49>` and
+  <https://github.com/awslabs/damon-tests/blob/master/corr/run.sh#L49>`_ and
   `kunittests
-  <https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh>`.
+  <https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh>`_.
 
 Further doing below and putting the results will be helpful.
 
 - Run `damon-tests/corr
-  <https://github.com/awslabs/damon-tests/tree/master/corr>` for normal
+  <https://github.com/awslabs/damon-tests/tree/master/corr>`_ for normal
   changes.
 - Run `damon-tests/perf
-  <https://github.com/awslabs/damon-tests/tree/master/perf>` for performance
+  <https://github.com/awslabs/damon-tests/tree/master/perf>`_ for performance
   changes.
 
 Key cycle dates
 ---------------
 
 Patches can be sent anytime.  Key cycle dates of the `mm-unstable
-<https://git.kernel.org/akpm/mm/h/mm-unstable>` and `mm-stable
-<https://git.kernel.org/akpm/mm/h/mm-stable>` trees depend on the memory
+<https://git.kernel.org/akpm/mm/h/mm-unstable>`_ and `mm-stable
+<https://git.kernel.org/akpm/mm/h/mm-stable>`_ trees depend on the memory
 management subsystem maintainer.
 
 Review cadence
@@ -72,13 +72,13 @@ Mailing tool
 Like many other Linux kernel subsystems, DAMON uses the mailing lists
 (damon@lists.linux.dev and linux-mm@kvack.org) as the major communication
 channel.  There is a simple tool called `HacKerMaiL
-<https://github.com/damonitor/hackermail>` (``hkml``), which is for people who
+<https://github.com/damonitor/hackermail>`_ (``hkml``), which is for people who
 are not very familiar with the mailing lists based communication.  The tool
 could be particularly helpful for DAMON community members since it is developed
 and maintained by DAMON maintainer.  The tool is also officially announced to
 support DAMON and general Linux kernel development workflow.
 
-In other words, `hkml <https://github.com/damonitor/hackermail>` is a mailing
+In other words, `hkml <https://github.com/damonitor/hackermail>`_ is a mailing
 tool for DAMON community, which DAMON maintainer is committed to support.
 Please feel free to try and report issues or feature requests for the tool to
 the maintainer.
@@ -98,8 +98,8 @@ slots, and attendees should reserve one of those at least 24 hours before the
 time slot, by reaching out to the maintainer.
 
 Schedules and available reservation time slots are available at the Google `doc
-<https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`.
+<https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing>`_.
 There is also a public Google `calendar
-<https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`
+<https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
 that has the events.  Anyone can subscribe it.  DAMON maintainer will also
 provide periodic reminder to the mailing list (damon@lists.linux.dev).
-- 
2.39.5

