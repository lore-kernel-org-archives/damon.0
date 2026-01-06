Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C029E101;
	Tue,  6 Jan 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709428; cv=none; b=oIB6129tTMZHJH+ZnYnBkjLU98izhNCnyGpEYB4CXac+WG1Rgs77RlPx19vWZXg+kr5prWhTyf7n8Gvk0I+BDtjaCrme1TKm/pRXe7ZK+0mTqCe+XaaqXTCXEJvNtuwpIa0ELfqRFA0h5By4CcNEsK61epXym7/Vu8E7z0Y7izc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709428; c=relaxed/simple;
	bh=3jNguRzdmpEokVkqzVSoAkozTh+fzxrD+46UVd0hpfo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=p48v21xEcy9M94ffHlJK7wprOBsUbaa0i1ezGYZ5xfFgjS3jUAqFuwgpiWq71qfC0K6//C+gu6nIRnbXSZRjLP0RzzDpW84k6ouCsm4KFYKd8cMCqEamIT75qcmDh8coSAyMFdHRBCyHEaSvknReKhMW+sGBMTRpu2Rwilgit88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mp0TAZrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mp0TAZrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3987EC19421;
	Tue,  6 Jan 2026 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767709427;
	bh=3jNguRzdmpEokVkqzVSoAkozTh+fzxrD+46UVd0hpfo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=mp0TAZrROQmE7cbZC1BpepIFNpOtz439ynBse+P+GorkEDZfFVGtM78/oGG8W/jir
	 mHNSJQAyOy20bCcCBS7KbT7vbv35jFubAAB8rxAgoNBlhegqwRPMYC1HvUqRNso9Jb
	 NkV+DlgeVf7ipdObAlCB3i6D+GalfDJPpIW6Ha0g=
Subject: Patch "mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()" has been added to the 6.18-stable tree
To: akpm@linux-foundation.org,brendan.higgins@linux.dev,damon@lists.linux.dev,davidgow@google.com,gregkh@linuxfoundation.org,sj@kernel.org,wangkefeng.wang@huawei.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Jan 2026 15:23:30 +0100
In-Reply-To: <20260106014249.364220-1-sj@kernel.org>
Message-ID: <2026010630-crushed-supplier-b830@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mm-damon-tests-core-kunit-handle-alloc-failures-on-damon_test_split_regions_of.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-204994-greg=kroah.com@vger.kernel.org Tue Jan  6 02:55:58 2026
From: SeongJae Park <sj@kernel.org>
Date: Mon,  5 Jan 2026 17:42:49 -0800
Subject: mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev, SeongJae Park <sj@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20260106014249.364220-1-sj@kernel.org>

From: SeongJae Park <sj@kernel.org>

damon_test_split_regions_of() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-9-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit eded254cb69044bd4abde87394ea44909708d7c0)
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/tests/core-kunit.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -278,15 +278,35 @@ static void damon_test_split_regions_of(
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 22);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 2, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "second target alloc fail");
+	}
 	r = damon_new_region(0, 220);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);


Patches currently in stable-queue which might be from sj@kernel.org are

queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-on-dasmon_test_merge_regions_of.patch
queue-6.18/mm-damon-tests-vaddr-kunit-handle-alloc-failures-on-damon_do_test_apply_three_regions.patch
queue-6.18/mm-damon-tests-core-kunit-handle-memory-failure-from-damon_test_target.patch
queue-6.18/mm-damon-tests-core-kunit-handle-allocation-failures-in-damon_test_regions.patch
queue-6.18/mm-damon-tests-core-kunit-fix-memory-leak-in-damon_test_set_filters_default_reject.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-on-damos_test_filter_out.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-on-damon_test_split_at.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failres-in-damon_test_new_filter.patch
queue-6.18/mm-damon-tests-vaddr-kunit-handle-alloc-failures-in-damon_test_split_evenly_fail.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-on-damon_test_set_filters_default_reject.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-in-damon_test_set_regions.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-on-damon_test_split_regions_of.patch
queue-6.18/mm-damon-tests-core-kunit-handle-memory-alloc-failure-from-damon_test_aggregate.patch
queue-6.18/mm-damon-tests-vaddr-kunit-handle-alloc-failures-on-damon_test_split_evenly_succ.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failure-on-damon_test_set_attrs.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failure-on-damos_test_commit_filter.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-in-damon_test_ops_registration.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-on-damon_test_merge_two.patch
queue-6.18/mm-damon-tests-sysfs-kunit-handle-alloc-failures-on-damon_sysfs_test_add_targets.patch
queue-6.18/mm-damon-tests-core-kunit-handle-alloc-failures-in-damon_test_update_monitoring_result.patch
