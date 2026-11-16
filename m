Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856224;
	b=sGhcfAW6IFNUxrh2fmDrlqXvd7Khqu9d8O68fMTTDAjIiDW/SEVx5s5fql079qidKBfr
	 CAVKd20pgnyhNKsRvJU+MJOQB75+DR2TrBYyfEAGB6vke3yY7JqyCr3V12Me09MaKca5h
	 9vg5n2/w/zwsJhIwfw9jDs1ss2+hGpmgNV6DFVXfyHALmGI/bCKUIRsMmd6yeyLy9SZEN
	 mWOu8b4ebTh8qxCVzOtWlAmKca6JrHUr8cP1Y9LZ/A8oZGng7AjJsHEB2Kteitw0XzWVo
	 zUHLIX7Oi3qLa2gQuKfikP+oz0A+P8BInb4jm/Z2R/xXNbiX79CrwC2IdqGYXfvpyEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856224;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5ymyID5yWGQWOMH6t/cr1gAlkP/MvA7c8+VMex67FU4=;
	b=ie7P4t6BHPfJGngmkAzezZdzcmk48KIc7hoSsHSBQML+FIpJmA1D4KQC8CWh9MSUev39
	 WTLQ0gIFknevYjAmK9HOA2URmXK/SVsdyr5Q4Lz1igfnp5SjvaeHoQqD+rGtmuvfyPONM
	 L33NEcrcbE7/i2YBIXEKaVQ/QhzhYknqBVXjP7oIic87JZHcnhdmWsvvI7OZbmAwTpH8c
	 2ikGIix9pUay9VDIhnW35qii4V5Lk3okFvdsN3Z2l3i9GBKN/1iitG+2TL6PTlGOii9yp
	 XpQiNFpsjCHaCkVvMW9mqI5qLeElWBqC5co4X0cL94CWP9nLkUeBEFlT1zvM31ZXzrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjG0ezQZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB37606A887;
	Mon, 16 Nov 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjG0ezQZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794856224;
	b=qULEkZaU5EZ4gCL0jcBG1du68dm/Zj+llvss1dyvXrtsvPIl7z5EK+w7SPY2iIVCYImI
	 oAy0zAQ8th1fMZey5YTLvamcckHJFy78AIVEzvdVFwXsvd9B63HuZqEBRrL2UweOYNln7
	 AwIrhvw1yjOjzao3zaQuQRzITh1umewYZ8lBj8TmKFKxfp+Z+QIWtHbtfnvkL91BeSYtv
	 5baQQstGdeey3z50kLGx7LuGBlcXds2xPRwJ+UYjaE+RxPZuNxYlUzIz6Lv0BCOqz5Dbm
	 +JvwQYHTS4UQDhirZsDB2EDR7j7uoLwVqH+rhjkCM+HoI8ikqpx+sFqOP6wbYUEnNxw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794856224;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5ymyID5yWGQWOMH6t/cr1gAlkP/MvA7c8+VMex67FU4=;
	b=WCR0tHxqCbdsOgi6nM6eL+GVxCoP0GG5VFnc2bDwTgjArIq1s8C+kBkIxhrzu1pxkbgK
	 juDd23skSRDmbinkId380IXd0nOwb/RfShuWnH249lCyTPkS91C2lvXei1gUhX2BdONrW
	 gruFC9hqiqBTIUdaDvZN2NSIUTmfqcnM4HKsRE/TxqumtLIJwGaPirI9owKzLZdWwXUHp
	 n40ENBqOUt6V7YrXMEdDG+/az1ujZcYq17ELYmgoleeBrsVmumKhRNUekttqwyZkuL8c/
	 dVVt4WECwgehXs81corz0L9gLfiAWcfs32u8m/etHxveZEGs5YI0snmw7p8pCY18J/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 222E61F000CF;
	Mon, 16 Nov 2026 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856224;
	bh=5ymyID5yWGQWOMH6t/cr1gAlkP/MvA7c8+VMex67FU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bjG0ezQZ+fnVbyojelDEgz9QF/RbN+Yvuh+moB7bWehPFGvQav/M1aSWiOVb6aa7T
	 Jt2RkbSVdU4/NwYpwtqI7jizCRHdG8/C7k7KFsMQjfPgVyG42R55pw8SLAynV/wN3M
	 kLji8rzA1sg9eYV1eLaH7/L6R3SXxmrTOe3FhejTWK7eygJWzMDSnoS5R3wNGm0Dxn
	 XdXCSQw6Tom9dwmIcxIerhEtv4VojIOKt4Ah6oSQp0hyGI/gwKhtW4Ae+Dr5tup3fr
	 IIwoAREYzAmrkH0Ra3PQO57MQ8MZiQep63l5nurq5iLJIQ/o0keqqvck/1rbMV6Sfu
	 bhEAiFfrfnKXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C02F14A5A9;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Mon, 16 Nov 2026 19:10:09 +0000
Subject: [PATCH 6/6] Docs/ABI/damon: update for sz_ops_filter_passed_last
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-damon-sz-ops-b4-v1-6-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
In-Reply-To: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794856219; l=1281;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=90a1wbT2PC+F+rhsnr9WMD8Unb+N/GP+Z2kT1pcYBmY=;
 b=hi4tgZIxtxR6RtG6s3uQhhJYxlS2HNzATbhpnuiqcnw5erFek5+RS0MAPJiH9qov+piDgHtK6
 oCziTYlozDbCijoYbcVkeCIhYexh+1IIvvma8bp8NvnmpRTf9a0dgFu
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 7bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON ABI document for the newly added DAMOS stat file,
sz_ops_filter_passed_last.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4acb2015c2f4..92348178e48a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -623,6 +623,13 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Reading this file returns the total size of memory that passed
 		DAMON operations layer-handled filters of the scheme in bytes.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_ops_filter_passed_last
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Reading this file returns the size of memory that passed DAMON
+		operations layer-handled filters of the scheme in bytes, in the
+		last apply interval of the scheme.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/qt_exceeds
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>

-- 
2.54.0-uber3


