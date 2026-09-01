Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48E3242D8;
	Tue,  1 Sep 2026 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223795; cv=none; b=dAm4F4Y/dD0iSghagWxqi5oKJwlWNK1s/cECeY6xl55kDyCDnB6njyVGfvxqDcvr92Lk5zLDSmaicaSyBVVcTeX+rPLdWLwLAoTyR7Qlv1E9y+qO1qaqe5cslO7kzA68dJgp2lNWiI6Hq6t20qRvyfeUSmD5uLxCym+0HvVwR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223795; c=relaxed/simple;
	bh=l3qJZIhVSgURVr3deMWgwXH066mtlvNTj3WZWICl0Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD3iA8hlfB4E6PN9RjERP0xQSGO7KkzoJw3mS48xRxdXgB+VY5XnjqlXMwEpcrONxG/yun1ufPF/wJPVnMN05w9Hk1fa8YfSo8tDMJzt1vcmh/2TqKa+qGYvtJ2RJKwBFUiDvdZ+s3PClQkx1XSeeTzcRtRtVYZtATAaH8U/O48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJZR+0kn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJZR+0kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17991F000E9;
	Tue,  1 Sep 2026 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223794;
	bh=woKBEbIMFtOyK1GVl+xRrcz9+WTfKDI3xViqIZ1ByqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJZR+0knq0AL7vYLE5VQ4SxQHjEFRaMNjUH4EKagbUOTNB65IsCsrQgnLZC8ayDnc
	 D7PY9JYGCm9e+owTZkC2iFTLQ7otxkK2A6b1E6z90sR0bjsyfg6K1qmKguZXoETfSO
	 2h0Rrv0OJ424KhNTi41+CHj5WGvnjnBlzq1937+ynpU0dHwVhUFyNfCRfd+EBCwEvn
	 1QtsBE7IUIbljcqnnX6oFn0sn3zyZdZjSdza/TMqDjAxJNRMEaWHWhetpTWf4DBJ0X
	 6VBS1x0ahC1/UHvGkCYNOg91Nu4vfQouUbnZlw1klFTIbQcfav1VXpcpgVZVq+qZdV
	 sYMX98emL2oNA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v4 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Mon, 31 Aug 2026 17:49:41 -0700
Message-ID: <20260901004942.89964-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831144732.80910-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 07:47:27 -0700 SJ Park <sj@kernel.org> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ========
> This patch set introduces a new autotuning which allows to collapse hot
> regions into hugepages.

Sashiko found no blocker for this series.  Sashiko sent findings to damon@
mailing list [1], and I replied to all the comments.  Please read those for
details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
