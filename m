Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA33B775A;
	Thu, 17 Sep 2026 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617950; cv=none; b=qIUj0fjP8APZ+qDZFABWTHPP28cQlpbsRXRDDicpz0vYiNIdOTym0Im1KkKIsFSKbg2nDffx7N6nP3jB+351k+YnQGF1kpsC37LjfDZFg9N7CBnNXEn4D+jsSrV1jJgpoDfWfePJkzpcUIfRl+XnONT6/nwmMWxuwbqhknh1q94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617950; c=relaxed/simple;
	bh=snrSQKW8Uoh93Q7sQbLRi7Hk1JT19chDk6GmQkiSwlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EE8cUeh7q/3k88wnQjaYhOdRAHEvMIwI++41+4q3G+Gcp2IIULdBcpE//hLNGNrB05RynuuM1Uerwuu8YjB0jJYRPL1TW/kzjEd+OdQLFloebyWgJeIC1DBCftotqULI11iEbofwh6Lzs3wCZBqDTJ+f4Unl6ckmL7mZ77IfPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anOYjV8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anOYjV8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19341F00899;
	Thu, 17 Sep 2026 04:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617948;
	bh=YMhruRxJ71aCSjWmA7d/+kJKddMflnbOBghZf4lSJQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=anOYjV8WCsTVncf3Vj6GaK/Mje5Z954BIPh7Ig2bs0MwnSsePdkjJNjToRs7jZ8Ql
	 sx71PURDHbmgVwzK3TSL0mqjxtVj5D11bJnnGzmWa/5thquojlNAwFwxi8hS67ZmQz
	 LDnEJEuaDWGfs28g9XjhJvInrUE5/j+ZB/xrft8CKJ3cpjNn3UQ/s9JRRUB3r4Tgyr
	 MvbTtcccdwLMt21apoMLyArSvBDzxTFZcQWCe5IOfrS73WVpTSnXcTyGBrlEH4AHox
	 D6OUEMYyUb4F8TAJSq80mU7ErhD8NaNlob9QNncLXBqsKw4Zc6dtLPRbQyAMXzs4Y2
	 jEm/M143L3rbg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/10] mm/damon/tests/core-kunit: add probe_hits_wsum damos filter commit test
Date: Wed, 16 Sep 2026 21:05:34 -0700
Message-ID: <20260917040537.107341-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filter commit kunit test lacks test cases for probe_hits_wsum
filter type.  Add test cases for probe_hits_wsum type DAMOS filter
commit.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 1244cfeae5e70..df84d9cc7d204 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1166,6 +1166,10 @@ static void damos_test_commit_filter_for(struct kunit *test,
 		KUNIT_EXPECT_EQ(test, dst->sz_range.min, src->sz_range.min);
 		KUNIT_EXPECT_EQ(test, dst->sz_range.max, src->sz_range.max);
 		break;
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		KUNIT_EXPECT_EQ(test, dst->range_min, src->range_min);
+		KUNIT_EXPECT_EQ(test, dst->range_max, src->range_max);
+		break;
 	default:
 		break;
 	}
@@ -1239,6 +1243,22 @@ static void damos_test_commit_filter(struct kunit *test)
 			.allow = true,
 			.target_idx = 6,
 			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+			.matching = false,
+			.allow = true,
+			.range_min = 12,
+			.range_max = 34,
+			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+			.matching = false,
+			.allow = true,
+			.range_min = 34,
+			.range_max = 12,
+			}, true);
 }
 
 static void damos_test_help_initailize_scheme(struct damos *scheme)
-- 
2.47.3
