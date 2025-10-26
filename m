Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D02DA777;
	Sun, 26 Oct 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502944; cv=none; b=KatPqsF3caQd/EVflwYqWn1CJuY34b9Vdg5INFiXV0CRWLOQxL4WKZcfSoF4YHqc7X+UI9V02896i6eJX3mrL/0IwpuowmGTDkqOY0cCOyCvLoUF2T/6D9nFfh24T3Jgkiw4WC71jAgh1rc/PaJe2uEhaHX3y+RSuw50APVe6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502944; c=relaxed/simple;
	bh=vR/jN1F5Lce+/wYJ3r7vPrVeoUjeNepMfhGqCYSRWqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B95mrDgfopvB3Vz4iLg0wweT8sDcx33rj5kzqcyaPhDvD5Vv5qUC87TuJM/0q1ks9R+/DW4IdF9PG/jXE6BX1QtmDXOKH4OlK6i3EwDNBqWVb6BGFBETPS1gkkmVHd17qX0W54W/73ZBhf8xylmrnNdzvxw4nDUmJ0AM/NJY5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrUXWisV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrUXWisV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913E6C116D0;
	Sun, 26 Oct 2025 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502943;
	bh=vR/jN1F5Lce+/wYJ3r7vPrVeoUjeNepMfhGqCYSRWqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrUXWisVTkQuT/o97FuvkpH48DZbMUE8mE2W8Umu5nU3QnHmLelcE5jBmq95VgdCr
	 pY/zhcBoT8GkIudvveTt1LFwjoCVwxxN58tWskdBWOJ/oadZBuZaTf9l499ApRhP+y
	 HYlXni3I9sVHVfTDml1uHzYVAxTRvsrBfbuTCCs81RZhz6a29HzIy0mOGp73H/lEDf
	 EesRjDcqND1pYBOzH7F9SFKGoUdGBZknts4E8rkxMqOhDQ1DXFTzbUs08qVOMlw4JS
	 +Bk5Womdr7dJUTyra0iV2Wvnrlg0W0qfP42AVCgCzLYoP78dpvJMA1MQboaEuCs/cG
	 DPdMcDpxOvNHg==
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] Docs/mm/damon/design: fix wrong link to intervals goal section
Date: Sun, 26 Oct 2025 11:22:07 -0700
Message-ID: <20251026182216.118200-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026182216.118200-1-sj@kernel.org>
References: <20251026182216.118200-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b243d666d107 ("Docs/admin-guide/mm/damon/usage: add
intervals_goal directory on the hierarchy") mistakenly added a wrong
reference for intervals goal usage documentation on the design document.
Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index b54925ea78e9..2d8d8ca1e0a3 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -381,8 +381,8 @@ That is, assumes 4% (20% of 20%) DAMON-observed access events ratio (source)
 to capture 64% (80% multipled by 80%) real access events (outcomes).
 
 To know how user-space can use this feature via :ref:`DAMON sysfs interface
-<sysfs_interface>`, refer to :ref:`intervals_goal <sysfs_scheme>` part of
-the documentation.
+<sysfs_interface>`, refer to :ref:`intervals_goal
+<damon_usage_sysfs_monitoring_intervals_goal>` part of the documentation.
 
 
 .. _damon_design_damos:
-- 
2.47.3
