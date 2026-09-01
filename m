Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E947DD7F;
	Tue,  1 Sep 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269118; cv=none; b=qaJN7WG8epW7KblsJgZEFkhns6AoiUHtj6ZNEhUzXTRjNLmfXjD/X1B2QSaXPgyyLueVkHDdsL8iX6Sylqz4/7c0jk4cKLY/UIQsPofZCKcp4qHnyZlAvdpOG4p4FYMkFFcSBii+8oofkH4/J/CI4/4UkrVSUnOi/D2EnTRwkJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269118; c=relaxed/simple;
	bh=9zsAoynOHHRc7GbHj8uhKfcJe1SrIdX7FjQmo/V/mBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i15RemIsPn0oMGcOXIZJuYYZ1LFzIwkqwqXvOKHt1N4rsmJB57uBzonAilOQrjje0MDk7P8ZfNf3vALtyyavPYMX8VxceYMUBOZg7hMBlaTFSQjuPbW+F3e+ABjdvPmF3/LLrweRzBq9rXbNZIvgqCQAYwFlmRMDx810CFawDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4Tz3IpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4Tz3IpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38581F00ADF;
	Tue,  1 Sep 2026 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269116;
	bh=vf/K9c9fWpOSUYmz+e9QIT0AziWQ1IhtxaGnZ535xtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4Tz3IpMlXR7MLDLlIDUWNNwlBsLxAczPgma1Zv+VzN3rl0T0kRNRX2Sjj5bIA8E7
	 I6SjkLXtgMnfsQgTC4+gwZdI6R5xZyMmPANuw+14YT9t9+fy0PK1g8APz41IzKzI+W
	 e1EFi3w3wRZmVXlkch3yBAqwjur6yu84iixvMbtnuAhkdtilt/odBX2x23TQXlGTA+
	 UmWtkwOETAJcOB79YOAtvLjrvp0zc6Z+V7dnU5+jc7Uc+p6WiNApQDb9BYtaZykYLr
	 Fi6pbfVzNmvsCwuiCB6u3vnS6BA04GQcpxOvSnaOG9zXIV4QW4NWlka6VH853OBNPN
	 x6TMaGB6xWViw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 04/17] Docs/mm/damon/design: document pgidle_unset probe filter type
Date: Tue,  1 Sep 2026 06:24:51 -0700
Message-ID: <20260901132506.99243-5-sj@kernel.org>
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

Update DAMON design document for the newly added pgidle_unset probe
filter type.  Also use a list for the types, as it becomes not very easy
to read the whole types in a simple sentence.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 63cbb7b536da2..947d91ae24a39 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -293,8 +293,12 @@ registration is made by specifying a probe per attribute.  Each of the probe
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
 same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
-for data attributes monitoring.
+filter types.  Currently below filter types are supported.
+
+- ``anon``: Same to that for DAMOS filters.
+- ``memcg``: Same to that for DAMOS filters.
+- ``pgidle_unset``: Matches if the page for the memory is marked as not
+  access-idle.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
