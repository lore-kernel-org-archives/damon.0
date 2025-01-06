Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64F14A095;
	Mon,  6 Jan 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192047; cv=none; b=TYi8HKRJW0W2EHCQOMH6qgpwuNMk28WcCvpQqoTfMDLeok1ML6cy2+PGxoS7Jj4qAINvul1CYBT/shoHatOfVE0K3ssPkUcLPSLNyaQX5bZnk5Mr7Ts/xIgbAyQft0NVgo8SghFTn2Vz3aYr/k11IQnMDu5nfmP0MIJZIQs+SZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192047; c=relaxed/simple;
	bh=XhcLRQFz4lACZiTbj0j93gzhhPoFRZF88CZ57hW+JkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jTnG/Zby04m0qjkcOJLbbRLsNi3IbPCY+oJuojUgadITG/sa5MPWBY+LydavtoHCRDLMCTdHQ16FcDb8A2uclc0eYy0UU0lTdJJTD65JgxegH3XIYi2YIGKhPRLFAymiUMa5MGxTkoyn9s537IBAMaaRvKoYZzEI1fec7gYcV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdFHWTw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdFHWTw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D99DC4CED2;
	Mon,  6 Jan 2025 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192046;
	bh=XhcLRQFz4lACZiTbj0j93gzhhPoFRZF88CZ57hW+JkE=;
	h=From:To:Cc:Subject:Date:From;
	b=AdFHWTw3GQOwVIfcP7xzr444nGD9UcnKCNmCKkgPd9t9YTnquh1SWkXF4ri/bKE25
	 1LJVAVMsTVwU6qlO2A1dpf+pdg3MvnphKEDw5y2eA8C8wAel8nvwycRDmsUDHEoHFw
	 nCpYfL8VbTdmPkfEVzXewzlvPBC7Uf1GgJrnaWr6XWaeyzCs64ItAhgjXnJLdDMTMU
	 7w+YGZSoedlJv/viURrdtwiiz2MfK4ST2LwqOHYObeQjvMd2diPwWZjq8GcsyLWUAR
	 8ROm5h4X3gB4Vr/yk+Ps/eo5VCsG/WuA/jSXgE/V6LrbrC+bAfb6mFeQ3qIokfrWAT
	 KBVqm4l0DnP7w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/16] mm/damon: enable page level properties based monitoring
Date: Mon,  6 Jan 2025 11:33:45 -0800
Message-Id: <20250106193401.109161-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR
======

This patch series enables access monitoring based on page level
properties including their anonymousness, belonging cgroups and
young-ness, by extending DAMOS stats and regions walk features with
region-internal DAMOS filters.

Background
==========

DAMOS has initially developed for only access-aware system operations.
But, efficient acces monitoring results querying is yet another major
usage of today's DAMOS.  DAMOS stats and regions walk, which exposes
accumulated counts and per-region monitoring results that filtered by
DAMOS parameters including target access pattern, quotas and DAMOS
filters, are the key features for that usage.  For tunings and
investigations, it can be more useful if only the information can be
exposed without making real system operational change.  Special DAMOS
action, DAMOS_STAT, was introduced for the purpose.

DAMOS fundametally works with only access pattern information in region
granularity.  For some use cases, fixed and fine granularity information
based on non access pattern properties can be useful, though.  For
example, on systems having swap devices that much faster than storage
devices for files, DAMOS-based proactive reclaim need to be applied
differently for anonymous pages and file-backed pages.

DAMOS filters is a feature that makes it possible.  It supports non
access pattern information including page level properties such as
anonymousness, belonging cgroups, and young-ness (whether the page has
accessed since the last access check of it).  The information can be
useful for tuning and investigations.  DAMOS stat exposes some of it via
{nr,sz}_applied, but it is mixed with operation failures.  Also,
exposing the information without making system operation change is
impossible, since DAMOS_STAT simply ignores the page level properties
based DAMOS filters.

Design
======

Expose the exact information for every DAMOS action including DAMOS_STAT
by implementing below changes.

Extend the interface for DAMON operations set layer, which contains the
implementation of the page level filters, to report back the amount of
memory that passed the region-internal DAMOS filters to the core layer.
On the core layer, account the operations set layer reported stat with
DAMOS stat for per-scheme monitoring.  Also, pass the information to
regions walk for per-region monitoring.  In this way, DAMON API users
can efficiently get the fine-grained information.

For the user-space, make DAMON sysfs interface collects the information
using the updated DAMON core API, and expose those to new per-scheme
stats file and per-DAMOS-tried region properties file.

Practical Usages
================

With this patch series, DAMON users can query how many bytes of regions
of specific access temperature is backed by pages of specific type.  The
type can be any of DAMOS filter-supporting one, including anonymousness,
belonging cgroups, and young-ness.  For example, users can visualize
access hotness-based page granulairty histogram for different cgroups,
backing content type, or youngness.  In future, it could be extended to
more types such as whether it is THP, position on LRU lists, etc.  This
can be useful for estimating benefits of a new or an existing
access-aware system optimizations without really committing the changes.

Patches Sequence
================

The patches are constructed in four sub-sequences.

First three patches (patches 1-3) update documents to have missing
background knowledges and better structures for easily introducing
followup changes.

Following three patches (patches 4-6) change the operations set layer
interface to report back the region-internal filter passed memory size,
and make the operations set implementations support the changed
symantic.

Following five patches (patches 7-11) implement per-scheme accumulated
stat for region-internal filter-passed memory size on core API
(damos_stat) and DAMON sysfs interface.  First two patches of those are
for code change, and following three patches are for documentation.

Finally, five patches (patches 12-16) implementing per-region
region-internal filter-passed memory size follows.  Similar to that for
per-scheme stat, first two patches implement core-API and sysfs
interface change.  Then three patches for documentation update follow.

Revision History
================

Changes from RFC
(https://lore.kernel.org/20241219040327.61902-1-sj@kernel.org)
- Fix kernel-doc undocumented parameter
  (https://lore.kernel.org/oe-kbuild-all/202412191225.f6bEMRT2-lkp@intel.com/)
- Drop walk_fn() invocation sequence and regions walk documentation
  - Those are moved to damos_call() intro patch series
    (https://lore.kernel.org/20250103174400.54890-1-sj@kernel.org)
- Wordsmith commit messages

SeongJae Park (16):
  mm/damon: clarify trying vs applying on damos_stat kernel-doc comment
  Docs/mm/damon/design: add 'statistics' section
  Docs/admin-guide/mm/damon/usage: link damos stat design doc
  mm/damon: ask apply_scheme() to report filter-passed region-internal
    bytes
  mm/damon/paddr: report filter-passed bytes back for normal actions
  mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action
  mm/damon/core: implement per-scheme ops-handled filter-passed bytes
    stat
  mm/damon/syfs-schemes: implement per-scheme filter-passed bytes stat
  Docs/mm/damon/design: document sz_ops_filter_passed
  Docs/admin-guide/mm/damon/usage: document sz_ops_filter_passed
  Docs/ABI/damon: document per-scheme filter-passed bytes stat file
  mm/damon/core: pass per-region filter-passed bytes to
    damos_walk_control->walk_fn()
  mm/damon/sysfs-schemes: expose per-region filter-passed bytes
  Docs/mm/damon/design: document per-region sz_filter_passed stat
  Docs/admin-guide/mm/damon/usage: document sz_filtered_out of scheme
    tried region directories
  Docs/ABI/damon: document per-region DAMOS filter-passed bytes stat
    file

 .../ABI/testing/sysfs-kernel-mm-damon         | 13 ++++
 Documentation/admin-guide/mm/damon/usage.rst  | 29 ++++----
 Documentation/mm/damon/design.rst             | 45 +++++++++++-
 include/linux/damon.h                         | 27 ++++++-
 mm/damon/core.c                               | 17 +++--
 mm/damon/paddr.c                              | 70 +++++++++++++++----
 mm/damon/sysfs-common.h                       |  2 +-
 mm/damon/sysfs-schemes.c                      | 35 +++++++++-
 mm/damon/sysfs.c                              |  5 +-
 mm/damon/vaddr.c                              |  2 +-
 10 files changed, 202 insertions(+), 43 deletions(-)

-- 
2.39.5
