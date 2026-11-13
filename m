Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547040;
	b=fNsF0klqGRT+5wh1GW7XGlzJG/Jhz5qOdDN9jsz6pBZoIodZlFRwv/jSVQaf37YhW7ES
	 HMNVajpZT5hGKMMERyrgwn3KM2zQj3NhDjVjb6r/OfroPckdDfJvSgVPYHN2MTS/zZMqS
	 ngKjfGqBP3tluxcr6GcNtWnGVJKvliYP6aMX1+y427vJVC+ap3kZopCMgbd8TMvaPFJ4R
	 XYNfCyN0U6QXEqcwy7hHp4G5Ob4cOgLrlsGUdvHqXpLUxZBqml/Ft8ucPzdve5Ykx+gSN
	 b6kW17VWkQjPfuo+cQMsDRmWqeF2J+R8h8DP9nUUE04w6LqySwGT73HiqbgnfAL+5XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O0KFYW6GQeuL89YBqW1qiLu+Kr/wUVvd+oaMVAmTWFA=;
	b=QhFWfkMlMtrWtUW8r8Y5ExHZhm3wjVwEVSRpi00EmnhUpeRUl/4duTVOVLyOpETWULY2
	 kitjGpabziAqBUHsk3LRr9BhaRPGHP83eNAgB+iAXoOe7VwrvbqbvI4y6GygqIfXu9uBe
	 PjYSjimZU8L2GS3e2lOElmR8E+ibFwzz5z19Ui6/68J/5krwJ17QVYbl1eObJLi0Ufma+
	 mUc5l0EWxF8d5UEZuIiiD7HunfYDZWrEa0o3emRFvUxSKOHKfjwr5r64zxIfUI4YMimyp
	 m07s+S+USYuv7+Kou8jvCIjb6FQefk3lLLKIlNyxLsFIookohjZ+7+y/jLQfBl25oEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DY52BRJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38364606A321;
	Fri, 13 Nov 2026 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DY52BRJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603121F000C4;
	Fri, 13 Nov 2026 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547039;
	bh=O0KFYW6GQeuL89YBqW1qiLu+Kr/wUVvd+oaMVAmTWFA=;
	h=From:To:Cc:Subject:Date;
	b=DY52BRJqtabD4Q+zldmRe3wCwGrf8R6w8sFAQKSmpKROsaMSzyoGsVSUAHcAJWXM8
	 bmsqZgCqc0rnuMdF+sr8bPknfcoMOqd4upTCiSZEjG7lYB5dc+YvBLnin78hTXsS4Y
	 2b0d41jVaGi05Qo65rhPyHd3VdzOcMgf/fMDcCjOg8x2iruEXncA0sAz1U7x+XS8sn
	 pUrDZFx+NdXueHdq+hFgkNVB1/QwqD1KIQWeaijAmGVA98TI/LX4Kxtph2JG/a8+SD
	 KcLQDBIAbhnj36SiS0n01TKZG+3qC+tngakpUaHcQJURT5AtP8PBapfA4tvvtMRM/B
	 zDttYkoi8uYhg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon: add lru-active probe filter type
Date: Thu, 12 Nov 2026 21:17:06 -0800
Message-ID: <20261113051711.89274-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LRU-activeness of folios is useful information for understanding and
optimizing the system.  DAMOS ops filter therefore supports filtering
memory based on the information.  Using it, the information can be
extracted in the folio granularity.  It is precise but expensive.  DAMON
probe filter is the complementary way for getting the information in
region granularity with much cheaper cost.  DAMON filter does not
support LRU-activeness based filtering, though.  Add the support.

Define new DAMON filter type, DAMON_FILTER_TYPE_ACTIVE, on core API
(patch 1).  Add support for it on both vaddr and paddr operation set
(patch 2).  Extend DAMON filter sysfs ABI to let users configure DAMON
filters of the type using a new keyword, "active" (patch 3).  Finally,
update the DAMON design document to explain the new type (patch 4).

Test
====

Confirmed the functionality like below.

First, start masim [1] to generate a ~476 MiB hot memory region.

    $ ./masim.py run --config_file ./configs/stairs-500mb.cfg --repeat 10

Second, start DAMON to monitor data access and active memory ratio of
each region using DAMON user-space tool (damo) [2].

    $ sudo ./damo start --target_pid $(pidof masim) \
            --probe --probe_prep set_pgidle \
                --probe_filter allow pgidle_unset \
            --probe --probe_filter allow active \
            --probe_weight 1 0

Show the monitoring results.

    $ sudo ./damo report attrs
    heatmap: 00008[...]82222222222222222222222222222222222222222222222257777789999998888888874444445[...]8
    # min/max temperatures: -1,580,000,000, 100,002,000, column size: 62.841 MiB
    probes
    - prep: set_pgidle, filter: allow pgidle_unset (weight: 1)
    - allow active (weight: 0)
    intervals: sample 5 ms aggr 100 ms (max probe hits 20)
    #   size         address       age           probe_hits
    0   253.047 MiB  85.984 TiB    15.800 s      0 0
    1   4.000 KiB    127.984 TiB   15.400 s      0 20
    2   120.000 KiB  127.984 TiB   15.300 s      0 0
    3   1.450 GiB    127.407 TiB   11.300 s      0 0
    4   498.738 MiB  127.409 TiB   11.200 s      0 0
    5   500.273 MiB  127.409 TiB   11.100 s      0 0
    6   502.055 MiB  127.409 TiB   10.900 s      0 0
    7   461.926 MiB  127.411 TiB   6.500 s       0 0
    8   351.754 MiB  127.410 TiB   1.600 s       0 0
    9   497.930 MiB  127.411 TiB   0 ns          1 0
    10  8.000 KiB    127.984 TiB   0 ns          6 0
    11  476.340 MiB  127.410 TiB   1 s           20 0
    memory bw estimate: 0 B per second
    total size: 4.909 GiB
    record DAMON intervals: sample 5 ms, aggr 100 ms

The second (idx 1) 4 KiB memory region is not accessed for 15 seconds
and the page for the region is on an active LRU list.  The last 476.340
MiB memory region is accessed for each sample for the last one second as
expected.  And nearly all pages of the region are not on an active LRU
list.

[1] https://github.com/sjp38/masim
[2] https://github.com/damonitor/damo

Changes from RFC
- RFC: https://lore.kernel.org/20261108191615.113362-1-sj@kernel.org
- Add test results on the cover letter.
- Rebase to the latest mm-new.
- Drop RFC tag.

The test section and the changelog can be removed from the final commit
message.

SJ Park (4):
  mm/damon/api: define DAMON_FILTER_TYPE_ACTIVE
  mm/damon/ops-common: implement DAMON_FILTER_TYPE_ACTIVE operation
  mm/damon/sysfs: support LRU-activeness based DAMON filter setup
  Docs/mm/damon/design: update for DAMON_FILTER_TYPE_ACTIVE

 Documentation/mm/damon/design.rst | 1 +
 include/linux/damon.h             | 2 ++
 mm/damon/ops-common.c             | 7 +++++++
 mm/damon/sysfs.c                  | 4 ++++
 4 files changed, 14 insertions(+)


base-commit: e055da336413b651d1e23d438bb5430f9350d3f8
-- 
2.47.3
