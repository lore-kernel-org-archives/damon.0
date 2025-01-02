Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92581420A8;
	Thu,  2 Jan 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852697; cv=none; b=BN9DT659aMdbMH9rCO9G+jw+7AEbjFyMPFd9bdnJ2KMqAWT3mlhKZCBbLwRZUz95bL4m62OssupyWrV9OLFbIes0BRFcFxbrq+QWGEPTbxQGkmZfsIWcNF425GGSP7HsWkWzsf7bDCGnwkMWMjVPgkVko46GH/tDNBOjU/u0IgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852697; c=relaxed/simple;
	bh=UYtCDyb4qNu3+Y+YAl3a+OYj3W+x58h/ymqddEi2SSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSlgHcDfSs2aDZHwrgIwQPKkyEMKK51by2/9Thy7pVxkhUFnDWu7sF9kyAMXQkK+kb5oNjhAU+ncfDGTMgE3TELQmX3reEQefBZfMbNUk46Cw8Be8I7Ohb3W/DmQ8kGSk5StP/4/qWP9zH2kNirswVFLVYwKPOyQwF33y7Hw8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeQ+0MKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeQ+0MKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A6C4CED0;
	Thu,  2 Jan 2025 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735852696;
	bh=UYtCDyb4qNu3+Y+YAl3a+OYj3W+x58h/ymqddEi2SSk=;
	h=From:To:Cc:Subject:Date:From;
	b=KeQ+0MKC8HZ+4PZX5zBVZYctgikQtDpt2UX2FfTN2OLByzQIQDhGEIvsUoB/K12UD
	 /MOy7M3uSuUfiffI/xGS0Le/xtHXJO2hKAUcFl58GeCajpB/a2EFFZC/QMehPpCsro
	 wuiHdH64K/JjbGLeBgvJzGueSKKiNbb7avSx+w1nCnURTg4Qrjr+yNjfPx3pKfRmXy
	 ZJ6TKjl9bzf7l8gFe2z08eaR4AyDnjcoegjdIu/PItns8r5hfJb0XzMQZQs1s2ke2l
	 FLfbK4zHOg8s6ngoGDTanXAY47qnwuHAWnJEgwQgDE+hcJ0JIRKa/6ZIl+bsKr9jt0
	 qGlGW/Zuj4Y+w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: DAMON Quaterly News Letter (Q4 2024)
Date: Thu,  2 Jan 2025 13:18:11 -0800
Message-Id: <20250102211811.48322-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello DAMON community,


Three more months have passed since the last DAMON quaterly news letter[0].
Let's look back what happened in the last three months.

Summary of Summaries
====================

- New features.  DAMON features and user-space supports for page level
  properties based monitoring and inclusive page level filtering are under
  development.  New access pattern visualizations including recency/temperature
  histogram and single snapshot heatmap have delivered with user-space tool
  (damo).
- More users.  Monthly PyPI downloads of DAMON user-space tool (damo) has
  spiked about ten times (from 2,345 at 2024-09-01 to 21,885 at 2024-11-04).
  The number has decreased to 8,915 by 2024-12-30 now.
- Presentations and Documents.  DAMON talk videos for OSSummit'EU 2024 and
  LPC'2024 are now available.  A DAMON monitoring parameters tuning guide and
  an example of it on a real server workload has shared.  DAMON talk for
  FOSDEM'25 kernel devroom has accepted.

More detailed list of news per each month follows.

October 2024
============

Official records of DAMON talks at OSSummit EU'24 and LPC'24, which presents
DAMON usages[2] and long term plans[3], have uploaded to YouTube.

PyPI downloads of DAMON user-space tool (damo) has rapidly increased.  The
30-days downloads count has increased from 2,345 at 2024-09-01 to 21,885 at
2024-11-04.  The number has decreased to 8,915 by 2024-12-30, though.  A
spreadsheet of the data is available[4].

DAMON debugfs interface removal RFC patch has posted[5].  DAMON project site
started hosting its own blog[6], instead of redirecting to posts on the
maintainer's personal blog.

November 2024
=============

DAMON user-space tool (damo) started supporting recency/temperature
histograms[7], temperature-based regions filtering[8], and single snapshot
heatmap visualizations[9].

A guide for DAMON monitoring parameters tuning has been posted[10].

December 2024
=============

DAMON monitoring parameter tuning guide exasmple on a real server workload has
been shared[11].

DAMON presentation proposal has accepted[12] to FOSDEM'25 kernel dev room.

Patch series for DAMON sample modues[13] have posted.  RFC patch series for
page level properties-based access monitoring[14] and inclusive DAMOS
filters[15] have been posted.  DAMON user-space tool support of page level
properties-based acces tool has been released[16].


Previous quaterly news letters
==============================

- 2024 Q3: https://lore.kernel.org/20241001191425.588219-1-sj@kernel.org
- 2024 Q2: https://lore.kernel.org/20240701212244.52288-1-sj@kernel.org
- 2024 Q1: https://lore.kernel.org/20240402191224.92305-1-sj@kernel.org

More Past DAMON News
====================

If you're interested in a humblie list of more DAMON events that happened in
past and curated by DAMON maintainer, please reach out to the project site's
news page [12].

References
==========

[1] "DAMON Quaterly News Letter (2024 Q3)",
    https://lore.kernel.org/20241001191425.588219-1-sj@kernel.org
[2] DAMON recipes officieal record, https://youtu.be/xKJO4kLTHOI?feature=shared
[3] DAMON long-term plan official record,
    https://youtu.be/mRU1ZeNB9WY?feature=shared
[4] Monthly PyPI downloads of DAMON user-space tool (damo),
    https://docs.google.com/spreadsheets/d/1j85oZWOn4-ifxHavtRyiU6GKbF3O1P0aahuoENxBvZY/edit?usp=sharing
[5] DAMON debugfs interface removal RFC patch series,
    https://lore.kernel.org/20241015175412.60563-1-sj@kernel.org
[6] DAMON project site's blog: https://damonitor.github.io/
[7] damo recency/temperature histograms support,
    https://github.com/damonitor/damo/blob/v2.5.4/USAGE.md#access-report-styles
[8] damo access temperature based results filtering,
    https://damonitor.github.io/posts/damo_2_5_7_features/
[9] damo single snapshot heatmap support,
    https://github.com/damonitor/damo/blob/v2.5.6/release_note#L6
[10] DAMON monitoring parameters tuning guide,
     https://lore.kernel.org/20241202175459.2005526-1-sj@kernel.org
[11] DAMON monitoring parameters tuning example,
     https://lore.kernel.org/20241202175459.2005526-1-sj@kernel.org
[12] DAMON talk at FOSDEM'25,
     https://fosdem.org/2025/schedule/event/fosdem-2025-4396-damon-kernel-subsystem-for-data-access-monitoring-and-access-aware-system-operations/
[13] DAMON sample modules patch series,
     https://lore.kernel.org/20241210215030.85675-1-sj@kernel.org
[14] Page level properties based monitoring RFC patch series,
     https://lore.kernel.org/20241219040327.61902-1-sj@kernel.org
[15] Inclusive DAMOS filters RFC patch series,
     https://lore.kernel.org/20241227210819.63776-1-sj@kernel.org
[16] damo page level properties based monitoring support,
     https://damonitor.github.io/posts/damon_sz_filter_passed/
[17] DAMON news page: https://damonitor.github.io/posts/damon_news/

Wrapup
======

So, those were yet another grateful three months.  Looking forward to get more
news!  If you have any question regarding DAMON, please feel free to reach out
to the community and/or me.


Thanks,
SJ
