Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A93B1EEF
	for <damon@lists.linux.dev>; Sun, 16 Aug 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786890188; cv=none; b=HEQBt0CvzBQkJhQ482IJ6aSvlRgLEFkZlSAMALKC1jXMe2ab+uGUIUxuWSfAA+B7TQwfkUrXqnuJp2CLb0gpBwm5mRYH/p2p2muVtiSaVW11ybvcoufx5ewLepRB94zdWGKG0lWQKgxkMie5dJkqZkvYqs82GTLE8uvThpwNcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786890188; c=relaxed/simple;
	bh=aJCxxTWPtwoBZ6fKwboPkrJD4uPFgZMJY9FISCbeF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqD+QS13IgAQLAuC4654gzObPJrjQ1eBRi/bI1jLgGM9TfyMmVi8FsyAe4X+7i0x4fAmFvSsKOBT1DhA154psOBqvWuZ3DxVJ1kNJ4WB3i13bjKlSgUWyZugkAUJKrAW9uNH2jjCoZlF5IcM09d+y0DVKolch2bmzbLACWojMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOk736YV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOk736YV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacb8416a1so24353035ad.1
        for <damon@lists.linux.dev>; Sun, 16 Aug 2026 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786890185; x=1787494985; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V80z3viJi/1rXBOV+LmIMGbRsmAIYZLeea8uFd5X4Y0=;
        b=WOk736YVv4tvYGs+fuUkXWzfNbhRH9TBEuNXj2FcxJAJF/jAp6UVTFskWQvHrJdP3/
         PvIDR6ISwFhuX4EEzuw3ZhMoq5wSQtkxlPYssPWjz0uikwCe6jFzK12zfrQBMbvmefyI
         kMH9Sg2LR/VBMu7X5HLGpHa6ByJ113tzKe0L2AVlJRm8khGHwQqpGvrqYPJAEkUiEmnq
         0z+PZbg3nW1rfdYfXK/wbpNpQbbo9K0FJqei67VAIoTvZnJ3rAF2YVHFQ10A8eLmJC8i
         2e06zyU+7XlYULGMfDCJe5d6jblYmAu/tyQEz6+WB5LcltKVtOsNWc/Jtmq80zC+rZko
         D3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786890185; x=1787494985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V80z3viJi/1rXBOV+LmIMGbRsmAIYZLeea8uFd5X4Y0=;
        b=ee1ZJ6Xeoq7LHiUZmehXxpIbdRgXgw/w+wNuWBcUYrIZvdyPYem+hMIUZJ1Ttp8afl
         NzebWGIT+owpqnR0Gw3vGjQJD40aqoKGds292VoI2taFm+/EJplFQSbahzzmy27R9HM1
         sochDk52zyfTAXX1YUprDs+m9z8KnCdOmbXAURuuMRah/ofYtZ88y5tsAlzyIuxzjGTR
         PtBeS50aj8UEXBlSo3hjI/Qqo/UPhMH/OmxktvsyOlCguwQ9ckwk3dJnOiMZ6WveJakj
         qHoog/UlLUT0ITQI28BSkZDm+JI25v4qLpmxr/sXKo+nQiD0bpBKmFdyHG8ClQj6EkU4
         k9Og==
X-Forwarded-Encrypted: i=1; AHgh+RpeOkQbmK3Uk+7G59myRxuUGt5E6aWxwgsMuxRfoZ+LiEtT9i8PE/Yj6n4i3/BbiP1MMB/J0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ/dpgtt01jfi/xsqhCdgW5NLIIIOmRqOE8C3HVkjkOVK4rD2i
	QqyseUZ15UER4J/hR2na8SFzA3VNt9NW9YWfXwq0zAnW/O/I6VxeIGJo
X-Gm-Gg: AR+sD12Y5De8/jOJ9X45rLmgb9FGbMy3POFGIT/UdSsOKBXqjve8AbzoXNasgM4w0L0
	fRUUgON4kzZOGP69YZLsWjk0az+292TD76c5rC9ymZdzqTvZQGA9KsspuQfLPVvx/ZHh867nkAs
	Qt4fuz5efnNzc9gh88iaBGBVdpgENIoq5XruB5nzx+RqqgF2k8DliTwPNDDYqTii+EVrwDTDG+u
	Mbp7O6b1ux7USeodO8RePQgo/Upvy6sClEO0C0bRdW2Dbp4mVSari5vGxdjrubVqqG/7L1x2ds6
	vBEHZQ4p5iTqUj0Yn9KRLagJ+8y5P5pggkrMnyAkOJos6feK7MRkTXx/Ud/7sdGXjDGuMqTANaQ
	VsHWvTGZhDy7yYMrsP5zCJ4OzcRDJd+f7ApVY9rnMM1MisIaxynSzigfwfoYFnRp43mTRo+y2Xy
	LYYvwxXD4ZHN9QfmggJPlqqDYog//EC9gDCSdUsWadkXLyZx37RHDdd29uqDOmshuYwW5NUPOgv
	oA9L0++Sl0mWWcioQ==
X-Received: by 2002:a17:902:ce8c:b0:2cf:afa5:b19a with SMTP id d9443c01a7336-2d3b0d13bb8mr212666695ad.11.1786890185194;
        Sun, 16 Aug 2026 07:23:05 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebc8199sm26102365ad.74.2026.08.16.07.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 07:23:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: will@kernel.org,
	mark.rutland@arm.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	kunwu.chan@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	"Lian Wang (ProcessMission)" <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [RFC PATCH 3/4] mm/damon/perf: add KUnit tests for the SPE record parser
Date: Sun, 16 Aug 2026 22:22:20 +0800
Message-ID: <20260816142222.689624-4-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816142222.689624-1-kunwu.chan@linux.dev>
References: <20260816142222.689624-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>

Add byte-exact tests for load and store records, timestamp terminators,
multiple records, PAD and ALIGNMENT packets, extended addresses, invalid
extended headers, error resynchronization, and records without a virtual
address.

Cover ALIGNMENT packets at both odd and already aligned stream offsets.
Also verify that a record split across two AUX snapshots leaves the tail
unchanged until the terminating packet becomes available.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang (ProcessMission) <lianux.mm@gmail.com>
---
 mm/damon/perf/spe_parser_test.c | 365 ++++++++++++++++++++++++++++++++
 1 file changed, 365 insertions(+)
 create mode 100644 mm/damon/perf/spe_parser_test.c

diff --git a/mm/damon/perf/spe_parser_test.c b/mm/damon/perf/spe_parser_test.c
new file mode 100644
index 000000000000..598d9fd7cdc7
--- /dev/null
+++ b/mm/damon/perf/spe_parser_test.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the DAMON perf ARM SPE record parser.
+ *
+ * Each parameterized case feeds a byte-exact SPE packet stream (same
+ * encodings and decode order as tools/perf/util/arm-spe-decoder) into
+ * spe_parse_one_record() and verifies the synthesized records, the
+ * return values, and the aux_tail accounting.  The loop mirrors
+ * spe_backend_drain() including the caller-side window shrink.
+ */
+
+#include <kunit/test.h>
+#include <linux/slab.h>
+
+#include "spe_parser.h"
+
+/**
+ * struct spe_parse_case - One parser test case.
+ * @name:	Parameter description (shown on failure).
+ * @stream:	Byte-exact SPE packet stream.
+ * @len:	@stream length.
+ * @exp_reports:	Expected SPE_PARSE_REPORT count.
+ * @exp_skips:		Expected SPE_PARSE_SKIP count.
+ * @exp_errors:		Expected SPE_PARSE_ERROR count.
+ * @exp_tail:		Expected st->aux_tail after the stream.
+ * @exp_va: Expected virtual address of the first REPORT record.
+ * @exp_tid: Expected tid of the first REPORT record.
+ * @exp_is_write: Expected access type of the first REPORT record.
+ */
+struct spe_parse_case {
+	const char *name;
+	const u8 *stream;
+	size_t len;
+	unsigned int exp_reports;
+	unsigned int exp_skips;
+	unsigned int exp_errors;
+	unsigned long exp_tail;
+	unsigned long exp_va;
+	u32 exp_tid;
+	bool exp_is_write;
+};
+
+static const u8 stream_store[] = {
+	0x66, 0x2a, 0x00, 0x00, 0x00,			/* CONTEXT: 64-bit EL1 tid=42 */
+	0xb2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x1000 */
+	0x49, 0x01,					/* OP-TYPE: ST */
+	0x01,						/* END */
+};
+
+static const u8 stream_ts_load[] = {
+	0xb2, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x2000 */
+	0x49, 0x00,					/* OP-TYPE: load */
+	0x71, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* TIMESTAMP end */
+};
+
+static const u8 stream_two[] = {
+	0x66, 0x2a, 0x00, 0x00, 0x00,			/* CONTEXT: 64-bit EL1 tid=42 */
+	0xb2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x1000 */
+	0x49, 0x01,					/* OP-TYPE: ST */
+	0x01,						/* END */
+	0xb2, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x2000 */
+	0x49, 0x00,					/* OP-TYPE: load */
+	0x01,						/* END */
+};
+
+static const u8 stream_pad[] = {
+	0x00, 0x00,					/* PAD prefix */
+	0x66, 0x2a, 0x00, 0x00, 0x00,			/* CONTEXT: 64-bit EL1 tid=42 */
+	0xb2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x1000 */
+	0x49, 0x01,					/* OP-TYPE: ST */
+	0x01,						/* END */
+	0x00, 0x00, 0x00,				/* PAD padding */
+};
+
+static const u8 stream_alignment[] = {
+	0x66, 0x2a, 0x00, 0x00, 0x00,			/* CONTEXT: tid 42, pos 0-4 */
+	0x20, 0x00,					/* ALIGNMENT at odd pos 5 */
+	0xb2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x1000 */
+	0x49, 0x00,					/* OP-TYPE: load */
+	0x01,						/* END */
+};
+
+static const u8 stream_alignment_aligned[] = {
+	0x20, 0x00,					/* ALIGNMENT at even pos 0 */
+	0x66, 0x2a, 0x00, 0x00, 0x00,			/* CONTEXT: 64-bit EL1 tid=42 */
+	0xb2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x1000 */
+	0x49, 0x00,					/* OP-TYPE: load */
+	0x01,						/* END */
+};
+
+static const u8 stream_bad[] = {
+	0xff,						/* unknown header */
+	0x66, 0x2a, 0x00, 0x00, 0x00,			/* CONTEXT: 64-bit EL1 tid=42 */
+	0xb2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x1000 */
+	0x49, 0x01,					/* OP-TYPE: ST */
+	0x01,						/* END */
+};
+
+static const u8 stream_skip[] = {
+	0x49, 0x00,					/* OP-TYPE: load */
+	0x01,						/* END, no address */
+};
+
+static const u8 stream_other_pkts[] = {
+	0x42, 0x05,					/* EVENTS (width 1) */
+	0x43, 0x06,					/* DATA-SOURCE (width 1) */
+	0x98, 0x00, 0x00,				/* COUNTER (width 2) */
+	0xb2, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x3000 */
+	0x49, 0x00,					/* OP-TYPE: load */
+	0x01,						/* END */
+};
+
+static const u8 stream_truncated[] = {
+	0x66, 0x2a, 0x00, 0x00, 0x00,			/* CONTEXT: 64-bit EL1 tid=42 */
+	0xb2, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x1000 */
+	0x49, 0x01,					/* OP-TYPE: ST, no END */
+};
+
+static const u8 stream_truncated_packet[] = {
+	0xb2, 0x00, 0x10,				/* short 8-byte address */
+};
+
+static const u8 stream_ext_addr[] = {
+	0x20, 0xb2,					/* EXTENDED ADDRESS, DATA_VIRT */
+	0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* VA 0x4000 */
+	0x49, 0x00,					/* OP-TYPE: load */
+	0x01,						/* END */
+};
+
+static const u8 stream_invalid_extended[] = {
+	0x20, 0x42, 0x00,				/* invalid extended EVENTS */
+	0x01,						/* END after resync */
+};
+
+static const u8 stream_pad_only[] = {
+	0x00, 0x00, 0x00,
+};
+
+static const u8 stream_empty[] = { 0x00 };
+
+static const struct spe_parse_case spe_parse_cases[] = {
+	{
+		.name = "store record",
+		.stream = stream_store,
+		.len = sizeof(stream_store),
+		.exp_reports = 1,
+		.exp_tail = 17,
+		.exp_va = 0x1000,
+		.exp_tid = 42,
+		.exp_is_write = true,
+	},
+	{
+		.name = "load record with timestamp terminator",
+		.stream = stream_ts_load,
+		.len = sizeof(stream_ts_load),
+		.exp_reports = 1,
+		.exp_tail = 20,
+		.exp_va = 0x2000,
+		.exp_tid = 0,
+		.exp_is_write = false,
+	},
+	{
+		.name = "two records in one window",
+		.stream = stream_two,
+		.len = sizeof(stream_two),
+		.exp_reports = 2,
+		.exp_tail = 29,
+		.exp_va = 0x1000,
+		.exp_tid = 42,
+		.exp_is_write = true,
+	},
+	{
+		.name = "pad-wrapped record",
+		.stream = stream_pad,
+		.len = sizeof(stream_pad),
+		.exp_reports = 1,
+		.exp_tail = 22,
+		.exp_va = 0x1000,
+		.exp_tid = 42,
+		.exp_is_write = true,
+	},
+	{
+		.name = "alignment packet at odd position",
+		.stream = stream_alignment,
+		.len = sizeof(stream_alignment),
+		.exp_reports = 1,
+		.exp_tail = 19,
+		.exp_va = 0x1000,
+		.exp_tid = 42,
+		.exp_is_write = false,
+	},
+	{
+		.name = "alignment packet at aligned position",
+		.stream = stream_alignment_aligned,
+		.len = sizeof(stream_alignment_aligned),
+		.exp_reports = 1,
+		.exp_tail = sizeof(stream_alignment_aligned),
+		.exp_va = 0x1000,
+		.exp_tid = 42,
+		.exp_is_write = false,
+	},
+	{
+		.name = "bad packet resync",
+		.stream = stream_bad,
+		.len = sizeof(stream_bad),
+		.exp_reports = 1,
+		.exp_errors = 1,
+		.exp_tail = 18,
+		.exp_va = 0x1000,
+		.exp_tid = 42,
+		.exp_is_write = true,
+	},
+	{
+		.name = "record without address",
+		.stream = stream_skip,
+		.len = sizeof(stream_skip),
+		.exp_skips = 1,
+		.exp_tail = 3,
+	},
+	{
+		.name = "events/source/counter packets ignored",
+		.stream = stream_other_pkts,
+		.len = sizeof(stream_other_pkts),
+		.exp_reports = 1,
+		.exp_tail = 19,
+		.exp_va = 0x3000,
+		.exp_is_write = false,
+	},
+	{
+		.name = "truncated trailing record retained",
+		.stream = stream_truncated,
+		.len = sizeof(stream_truncated),
+		.exp_tail = 0,
+	},
+	{
+		.name = "truncated packet retained",
+		.stream = stream_truncated_packet,
+		.len = sizeof(stream_truncated_packet),
+		.exp_tail = 0,
+	},
+	{
+		.name = "extended address packet",
+		.stream = stream_ext_addr,
+		.len = sizeof(stream_ext_addr),
+		.exp_reports = 1,
+		.exp_tail = 13,
+		.exp_va = 0x4000,
+		.exp_is_write = false,
+	},
+	{
+		.name = "invalid extended header resync",
+		.stream = stream_invalid_extended,
+		.len = sizeof(stream_invalid_extended),
+		.exp_skips = 1,
+		.exp_errors = 1,
+		.exp_tail = sizeof(stream_invalid_extended),
+	},
+	{
+		.name = "pad-only window",
+		.stream = stream_pad_only,
+		.len = sizeof(stream_pad_only),
+		.exp_tail = 3,
+	},
+	{
+		.name = "empty window",
+		.stream = stream_empty,
+		.len = 0,
+		.exp_tail = 0,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(spe_parse, spe_parse_cases, name);
+
+static void spe_parse_case_test(struct kunit *test)
+{
+	const struct spe_parse_case *tc = test->param_value;
+	struct spe_parser_state st = { 0 };
+	struct spe_record rec;
+	u8 *buf;
+	unsigned int reports = 0, skips = 0, errors = 0, guard = 0;
+	bool first_checked = false;
+
+	buf = kunit_kmalloc(test, tc->len ?: 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	memcpy(buf, tc->stream, tc->len);
+	st.win = buf;
+	st.win_size = tc->len;
+
+	while (guard++ < SPE_BUFFER_MAX_RECORDS) {
+		unsigned long tail0 = st.aux_tail;
+		unsigned long consumed;
+		int ret = spe_parse_one_record(&st, &rec);
+
+		if (ret == SPE_PARSE_NEED_MORE)
+			break;
+
+		/* caller-side window shrink, mirrors spe_backend_drain() */
+		consumed = st.aux_tail - tail0;
+		st.win_size -= consumed;
+		memmove(st.win, st.win + consumed, st.win_size);
+
+		switch (ret) {
+		case SPE_PARSE_REPORT:
+			reports++;
+			if (!first_checked) {
+				KUNIT_EXPECT_EQ(test, tc->exp_va, rec.va);
+				KUNIT_EXPECT_EQ(test, tc->exp_tid, rec.tid);
+				KUNIT_EXPECT_EQ(test, tc->exp_is_write,
+						rec.is_write);
+				first_checked = true;
+			}
+			break;
+		case SPE_PARSE_SKIP:
+			skips++;
+			break;
+		case SPE_PARSE_ERROR:
+			errors++;
+			break;
+		}
+	}
+
+	KUNIT_EXPECT_EQ(test, tc->exp_reports, reports);
+	KUNIT_EXPECT_EQ(test, tc->exp_skips, skips);
+	KUNIT_EXPECT_EQ(test, tc->exp_errors, errors);
+	KUNIT_EXPECT_EQ(test, tc->exp_tail, st.aux_tail);
+	KUNIT_EXPECT_EQ(test, tc->exp_tail, st.bytes);
+	KUNIT_EXPECT_EQ(test, tc->exp_reports, st.records);
+}
+
+static void spe_split_record_test(struct kunit *test)
+{
+	struct spe_parser_state st = {
+		.win = (u8 *)stream_store,
+		.win_size = sizeof(stream_store) - 1,
+	};
+	struct spe_record rec;
+	int ret;
+
+	ret = spe_parse_one_record(&st, &rec);
+	KUNIT_ASSERT_EQ(test, SPE_PARSE_NEED_MORE, ret);
+	KUNIT_EXPECT_EQ(test, 0UL, st.aux_tail);
+	KUNIT_EXPECT_EQ(test, 0UL, st.bytes);
+
+	/* The next AUX copy starts at the unchanged tail and includes END. */
+	st.win_size = sizeof(stream_store);
+	ret = spe_parse_one_record(&st, &rec);
+	KUNIT_ASSERT_EQ(test, SPE_PARSE_REPORT, ret);
+	KUNIT_EXPECT_EQ(test, (unsigned long)sizeof(stream_store),
+			st.aux_tail);
+	KUNIT_EXPECT_EQ(test, 0x1000UL, rec.va);
+	KUNIT_EXPECT_EQ(test, 42U, rec.tid);
+}
+
+static struct kunit_case spe_parser_test_cases[] = {
+	KUNIT_CASE_PARAM(spe_parse_case_test, spe_parse_gen_params),
+	KUNIT_CASE(spe_split_record_test),
+	{},
+};
+
+static struct kunit_suite spe_parser_test_suite = {
+	.name = "damon_perf_spe_parser",
+	.test_cases = spe_parser_test_cases,
+};
+
+kunit_test_suite(spe_parser_test_suite);
-- 
2.43.0

