Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDE33F392;
	Sat,  7 Mar 2026 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912547; cv=none; b=RmLVj4Q13HRk5CETIDyLOqt7RjF+xlMAVz8pqoKbITfDmKscuWB/iA/EotZ8frtf+TsVEHpdQ6VCMYReT5QOisXySoqUwSRzRWBknwjVcyaYsI3sFnjBF17z395Kbyh06skZhcVH/VT28ko7nARvKMo754ILVTb2VFbhTgyJeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912547; c=relaxed/simple;
	bh=XcYOzSBU2Ik0HwEKQuQLPbmzqjVamPRGuDKVpDrdtlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoEq0Sl3mAMEWdnBZCRq6gNNJsuGpBpQQkGR0jmhNofXWG8I542S7LuaDYJrBe3jtFrsDv+UxvOfedV1i464HOOygBEb7Zb5bP45uMcFRG/eiEcYsJnFUdyyPBYUjyBOzEIS9VxaCQM5B+Rj9tYnO513kwiMFPMf2nk2iPmvroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTzb+iLN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTzb+iLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382E4C19422;
	Sat,  7 Mar 2026 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772912546;
	bh=XcYOzSBU2Ik0HwEKQuQLPbmzqjVamPRGuDKVpDrdtlQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FTzb+iLNu/uBbbSdvLtNPcvv40maRDEccaneyljx8hs90sXB3yQ6NIkDmcP1yiY2V
	 l4oL3AfHGNf5pNtb5zde1mcXnIT8/nchwCm5tQgndCyA8BaCSxYlF5oc+oDAYUcXa3
	 ZAI7EHpezLNrc/lXfXJ21FZWlJ+Y8GYEpyqjAgjcqLAw7y75iSm44rNKFQqpQbdJdh
	 QN7uOCqQix1dem5EPQvQNMg3YJ0tNE+TJ0p2GPZ9qq1wmbRKG1Oy0ApUxmEygjUnDj
	 kf/si1+GP5vCWQ0lu/n9ku4rzZjtxJ8Pc0TbgXNUFhRcf43zgFNtLVN9zOzAylqdBS
	 HAI2NK96bH8mQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: test and document power-of-2 min_region_sz requirement
Date: Sat,  7 Mar 2026 11:42:19 -0800
Message-ID: <20260307194222.202075-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit c80f46ac228b ("mm/damon/core: disallow non-power of two
min_region_sz"), min_region_sz is always restricted to be a power of
two.  Add a kunit test to confirm the functionality.  Also, the change
adds a restriction to addr_unit parameter.  Clarify it on the document.

SeongJae Park (2):
  mm/damon/tests/core-kunit: add a test for damon_commit_ctx()
  Docs/mm/damon/design: document the power-of-two limitation for
    addr_unit

 Documentation/mm/damon/design.rst |  2 ++
 mm/damon/tests/core-kunit.h       | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)


base-commit: 4380f0b6370ead5000b8d155b25a86cb59d68c06
-- 
2.47.3
