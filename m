Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BF17C220;
	Thu,  2 Jan 2025 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735840824; cv=none; b=MnXgC5wqQYnleGPtNgt2M1+QfXSIy0IYXKPNo2v8WpFZeiCBLhVblwM0DaZB3zR7BkNDmQ6U7MK+CeAFUI0AyBW7yn3/EOupAQRVJj6q8l6zsar8m+GTxsT447z9U2tjeycpoiXRi3APaqOqz1bUTq1qcyxbstVkHmMTnRNkfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735840824; c=relaxed/simple;
	bh=Qj6Vi+cCoEpj+xxJDyjM/jsYt8XRH2kLoMBA7rnKpqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSvrRHIRaCeSz7xAHH8Jrsnmcjx9XwjIDC/UHJOwaosMS7229AYgOV5jMDFwvwYQYsek4CVODKpl6u+6WFC06Nk/ruf3M4xCDGKUVXjdALAJz300kSJeWQqUewdbyfFnIlm0lzvOWWdzT9dRYIqhdrZ3DWyz0H6m6ByWVuohiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCPO9uSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCPO9uSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18B6C4CED0;
	Thu,  2 Jan 2025 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735840824;
	bh=Qj6Vi+cCoEpj+xxJDyjM/jsYt8XRH2kLoMBA7rnKpqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCPO9uSE6fuG82QXUdh0UjXBNn0FliqcCNby6+vXW2HBXxFUAMbKR3+d9b9wGyBf3
	 ciOHnsmBk9RJ9CV4YL17zeeOoNDdnQEspQvvdyWEJ254ZsPxLe0JM0lMYM0VQwnAxy
	 Mib7PvF1v+Q1iO2OOG2JwaanqvogfeLgM8u5jdipdFJQU5UjhFgcnrPGGlhXmWebFO
	 7RZ5PfpqCV5soCfZELUrXdJAI6LC1QFRQk7ZI782vQx/lurlMT2yVTzOjYyRtWInr0
	 mZP3SIDdWfbevlTzX9/0jyJhwROsY1VIXGx/hCg6X+OmXEmv2H34prQ28GGxNQEsLI
	 u4t8raqNqEhQg==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of Future
Date: Thu,  2 Jan 2025 10:00:19 -0800
Message-Id: <20250102180019.45333-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <Z3avJl1AJYG96RAA@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Jan 2025 10:22:14 -0500 Gregory Price <gourry@gourry.net> wrote:

> On Thu, Jan 02, 2025 at 04:09:38AM +0000, Matthew Wilcox wrote:
> > On Wed, Jan 01, 2025 at 02:20:39PM -0800, SeongJae Park wrote:
> > > Hi all,
> > > 
> > > 
> > > I find a few interesting and promising projects that aim to do efficient access
> > > pattern-aware memory management of near future, including below (alphabetically
> > > sorted).
> > > 
> > > - CXL hotness monitoring unit
> > >   (https://lore.kernel.org/20241121101845.1815660-1-Jonathan.Cameron@huawei.com)
> > > - Memory tiering fainess by per-cgroup control of promotion and demotion
> > >   (https://lore.kernel.org/20241108190152.3587484-1-kaiyang2@cs.cmu.edu)
> > > - Promotion of unmapped page cache folios
> > >   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)
> > 
> > I'm not sure how DAMON can help with this one.  As I understand DAMON,
> > it monitors accesses to user addresses.  This patchset is trying to solve
> > the problem for file pages which aren't mapped to userspace at all.
> > ie only accessed through read() and write().
> 
> DAMON can monitor physical addresses to, though the mechanism is
> different.

Thank you for answering this, Gregory.  As Gregory explained, users can use
physical address monitoring mode of DAMON for this.  For unmapped pages, DAMON
sets and reads PG_idle to check if it is accessed or not.  Since PG_idle is
respected by read() and write() use case to my understanding, DAMON should be
able to check accesses to unmapped pages.

> I haven't assessed this as a solution, yet.

To quickly see this, I ran below simple test.

First, I start DAMON in physical address space monitoring mode, wait for one
minutes to let it monitor the accesses of the system, and show the access
pattern on the system in access temperature histogram format.

$ sudo ./damo start
$ sleep 60
$ sudo ./damo report access --style temperature-sz-hist
<temperature> <total size>
[-7,480,000,000, -7,479,999,999) 59.868 GiB |                    |
total size: 59.868 GiB

The access temperature histogram format shows size of memory of given access
temperature range.  Access temperature is a metric that represents the access
hotness.  If any access to the region is continuously found, the value
increases.  If no access to the region is found, the temperature becomes zero.
If it continues showing no access, the temperature further decreases (goes to
minus).  Refer to the document[1] for more details.

So from the above output, we can show all memory of the system is not accessed
at all for the last minute.

Now I start a program that continuously overwrites 10 GiB file in background.
Attaching the source code (Attachment 0, dd_like.c) at the bottom of this mail.

After a few seconds, I show the temperature histogram again.

$ sudo ./damo report access --style temperature-sz-hist
<temperature> <total size>
[-12,590,000,000, -11,699,000,000) 42.038 GiB |********************|
[-11,699,000,000, -10,808,000,000) 0 B        |                    |
[-10,808,000,000, -9,917,000,000)  0 B        |                    |
[-9,917,000,000, -9,026,000,000)   0 B        |                    |
[-9,026,000,000, -8,135,000,000)   5.986 GiB  |***                 |
[-8,135,000,000, -7,244,000,000)   0 B        |                    |
[-7,244,000,000, -6,353,000,000)   0 B        |                    |
[-6,353,000,000, -5,462,000,000)   0 B        |                    |
[-5,462,000,000, -4,571,000,000)   0 B        |                    |
[-4,571,000,000, -3,680,000,000)   5.951 GiB  |***                 |
[-3,680,000,000, -2,789,000,000)   5.893 GiB  |***                 |
total size: 59.868 GiB

We can show DAMON found about 10 GiB relatively hot regions.

This is a very simple test that not well tuned.  Maybe because of that, there
are details to investigate, including why the 10 GiB regions are having
different and negative access temperature.  I'll skip those for now, since the
point of this test is that DAMON at least somehow react to accesses for
unmapped pages.

[1] https://github.com/damonitor/damo/blob/next/USAGE.md#access-temperature


Thanks,
SJ

> 
> ~Gregory

==== Attachment 0 (dd_like.c) ====
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

int main(int argc, char *argv[]) {
	int block_size, count;
	char *dest_path;

	if (argc != 4) {
		printf("Usage: ./dd_simulator <block_size> <count> <destination_file>\n");
		return 1;
	}

	block_size = atoi(argv[1]);
	count = atoi(argv[2]);
	dest_path = argv[3];

	// Validate input parameters
	if (block_size <= 0 || count <= 0) {
		fprintf(stderr, "Invalid block size or count\n");
		return 1;
	}

	// Write block size of zeroes 'count' times
	char *zeroes = calloc(block_size, sizeof(char));
	if (!zeroes) {
		fprintf(stderr, "Memory allocation failed\n");
		return 1;
	}

	while (1) {
		// Open destination file in write mode
		FILE *dest_file = fopen(dest_path, "w");
		if (!dest_file) {
			fprintf(stderr, "Failed to open %s for writing: %s\n", dest_path, strerror(errno));
			return 1;
		}

		// Write block size of zeroes 'count' times
		for (int i = 0; i < count; i++)
			fwrite(zeroes, block_size, 1, dest_file);

		fclose(dest_file);
		printf("one pass");
	}
	free(zeroes);
	return 0;
}
