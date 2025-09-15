Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657D1FBCB0;
	Mon, 15 Sep 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961845; cv=none; b=ZBy6A62cS5nviRMRBHLL9dGTVUqnvEyzSyx1lBOUofS27QR8WA8Pc3QGDIvfrrjhB4DLvxmy1kaQZxePRh+b0o9jOjca4uD6YFrElavRZVfUsms69g/XkPfe3BWGPAodAMXqqPp0HfO0DbWdbuCXCy0CFaNUWndeMJ7d13u5w24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961845; c=relaxed/simple;
	bh=5eM7L2bJi+aIvVJOlm9jGV5Bxc2GCKc2GP0RXo1z1Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlUC7xU9m2OBB1KOtQa5hYDAJ5cSZR7MK3OubhagrC5k9bSlrCMYmNBpyVIvFDnE/E/Q9bBa950PRWBa4msScmYcKeAlPQYDXWEcK+OwotoJ/YGy1r8n39hfRtP/jYkXvwWM+qGImgXb3D6WTVLViAq1LA86lQaeucu+tAAC2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVXNFqMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVXNFqMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AAFC4CEF1;
	Mon, 15 Sep 2025 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961845;
	bh=5eM7L2bJi+aIvVJOlm9jGV5Bxc2GCKc2GP0RXo1z1Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVXNFqMFCL2JfcNzfC2tFW0Bo8l5oT6Hep0aT7epPj5WMJQ9pc5s1nAx2sPWTU5MB
	 SQQhBtqrssxO2kWPjuMxdcFu7xDvcA29w5ew3P8MjWv8HoocE0RV0AK2eZp+V2tatT
	 CV2kQ3dUEpSHleg+X7ElNxJhx+u2Bhu7jVo23JufaSwESwaPyhzxWcmFqw33KghvM4
	 dTbYrOhTEzrHNC9z33EUkRxFuvyTQJiIAHK5gw0SEy70JbmMbV16DNGtRrT+0WXkzJ
	 v2wg7l64wFDid4SWurxcD9ka3iS84jdaXKhg3ukxqrcloBKQbGzoe2cJn3BOKClFUz
	 KGwGYby9BtaNg==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/6] Docs/mm/damon/maintainer-profile: update community meetup for reservation requirements
Date: Mon, 15 Sep 2025 11:44:02 -0700
Message-Id: <20250915184402.110517-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915150702.1499965-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 08:07:01 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Sun, 14 Sep 2025 18:58:05 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON community meetup was having two different kinds of meetups:
> > reservation required ones and unrequired ones.  Now the reservation
> > unrequested one is gone, but the documentation on the maintainer-profile
> > is not updated.  Update.
> 
> LGTM!
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you!


Thanks,
SJ

[...]
